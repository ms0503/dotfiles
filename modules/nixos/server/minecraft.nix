{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
  bluemap-permission-fixer = pkgs.writeScriptBin "bluemap-permission-fixer" ''
    #!${pkgs.bash}/bin/bash
    set -euo pipefail
    declare -r idx=$1
    ${pkgs.findutils}/bin/find "/data/mcsrv/bluemap/$idx/web" -perm 0600 -exec ${pkgs.coreutils}/bin/chmod 0644 {} +
    ${pkgs.findutils}/bin/find "/data/mcsrv/bluemap/$idx/web" -perm 0700 -exec ${pkgs.coreutils}/bin/chmod 0755 {} +
    ${pkgs.findutils}/bin/find "/data/mcsrv/bluemap/$idx/web" -perm 0744 -exec ${pkgs.coreutils}/bin/chmod 0755 {} +
  '';
  cfg = config.ms0503.server.minecraft;
  stop-script = pkgs.writeScriptBin "minecraft-server-stop" ''
    #!${pkgs.bash}/bin/bash
    set -euo pipefail
    declare -r idx=$1
    declare -ir pid=$2
    echo stop >"/run/minecraft-server-$idx.stdin"
    while kill -0 "$pid" 2>/dev/null; do
      sleep 1
    done
  '';
in
{
  config = mkIf cfg.enable {
    networking.firewall = {
      allowedTCPPorts =
        (cfg.servers |> builtins.attrValues |> builtins.map (server: server.port))
        ++ (
          cfg.servers
          |> builtins.attrValues
          |> builtins.filter (server: server.rcon.enable)
          |> builtins.map (server: server.rcon.port)
        );
      allowedUDPPorts =
        cfg.servers
        |> builtins.attrValues
        |> builtins.filter (server: server.query.enable)
        |> builtins.map (server: server.query.port);
    };
    systemd = {
      services = {
        "bluemap-permission-fix@" = {
          description = "Bluemap Permission Fixer, name:%i";
          serviceConfig = {
            ExecStart = "${bluemap-permission-fixer}/bin/bluemap-permission-fixer %i";
            Type = "oneshot";
            User = "minecraft";
          };
        };
        "minecraft-server@" = {
          after = [
            "minecraft-server@%i.socket"
            "network.target"
          ];
          description = "Minecraft Server Service, name:%i";
          environment.LD_LIBRARY_PATH =
            with pkgs;
            [
              udev
            ]
            |> lib.makeLibraryPath;
          requires = [
            "minecraft-server@%i.socket"
          ];
          serviceConfig = {
            CapabilityBoundingSet = [
              ""
            ];
            DeviceAllow = [
              ""
            ];
            EnvironmentFile = "/srv/mcsrv/%i/.env";
            ExecStart = "${pkgs.bash}/bin/bash /srv/mcsrv/%i/run.sh";
            ExecStop = "${stop-script}/bin/minecraft-server-stop %i $MAINPID";
            LockPersonality = true;
            PrivateDevices = true;
            PrivateTmp = true;
            PrivateUsers = true;
            ProtectClock = true;
            ProtectControlGroups = true;
            ProtectHome = true;
            ProtectHostname = true;
            ProtectKernelLogs = true;
            ProtectKernelModules = true;
            ProtectKernelTunables = true;
            ProtectProc = "invisible";
            Restart = "always";
            RestrictAddressFamilies = [
              "AF_INET"
              "AF_INET6"
            ];
            RestrictNamespaces = true;
            RestrictRealtime = true;
            RestrictSUIDSGID = true;
            StandardError = "journal";
            StandardInput = "socket";
            StandardOutput = "journal";
            SystemCallArchitectures = "native";
            Type = "simple";
            UMask = "0077";
            User = "minecraft";
            WorkingDirectory = "/srv/mcsrv/%i";
          };
        };
      };
      sockets."minecraft-server@" = {
        bindsTo = [
          "minecraft-server@%i.service"
        ];
        socketConfig = {
          FlushPending = true;
          ListenFIFO = "/run/minecraft-server-%i.stdin";
          RemoveOnStop = true;
          SocketGroup = "minecraft";
          SocketMode = "0660";
          SocketUser = "minecraft";
        };
      };
      targets = {
        multi-user.wants =
          cfg.servers
          |> lib.mapAttrsToList (
            name: _: [
              "bluemap-permission-fix@${name}.service"
              "minecraft-server@${name}.service"
            ]
          )
          |> lib.flatten;
        timers.wants = cfg.servers |> lib.mapAttrsToList (name: _: "bluemap-permission-fix@${name}.timer");
      };
      timers."bluemap-permission-fix@" = {
        description = "Timer for bluemap-permission-fix";
        timerConfig = {
          AccuracySec = "1us";
          OnCalendar = "*:*:00/5";
          Persistent = true;
          RandomizedDelaySec = "1s";
        };
      };
      tmpfiles.rules =
        cfg.servers
        |> lib.mapAttrsToList (
          name: server:
          let
            dotenv = pkgs.writeText ".env" ''
              JAVA_HOME=${server.jre}
            '';
          in
          "L+ /srv/mcsrv/${name}/.env - minecraft minecraft - ${dotenv}"
        );
    };
    users = {
      groups.minecraft = { };
      users.minecraft = {
        createHome = true;
        description = "Minecraft server service user";
        group = "minecraft";
        home = "/srv/mcsrv";
        isSystemUser = true;
      };
    };
  };
  options.ms0503.server.minecraft = {
    enable = mkEnableOption "minecraft servers";
    servers = mkOption {
      default = { };
      description = "List of server definitions.";
      type = types.attrsOf (
        types.submodule {
          options = {
            jre = mkOption {
              description = "Java runtime for running server.";
              type = types.package;
            };
            port = mkOption {
              description = "TCP port of game server.";
              example = 25565;
              type = types.port;
            };
            query = mkOption {
              description = "Settings of query server.";
              type = types.submodule {
                options = {
                  enable = mkEnableOption "query server of minecraft server";
                  port = mkOption {
                    description = "UDP port of query server.";
                    example = 25565;
                    type = types.port;
                  };
                };
              };
            };
            rcon = mkOption {
              description = "Settings of rcon server.";
              type = types.submodule {
                options = {
                  enable = mkEnableOption "rcon server of minecraft server";
                  port = mkOption {
                    description = "TCP port of rcon server.";
                    example = 25575;
                    type = types.port;
                  };
                };
              };
            };
          };
        }
      );
    };
  };
}
