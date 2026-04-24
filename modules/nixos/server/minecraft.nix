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
      services."minecraft-server@" = {
        after = [
          "minecraft-server@%i.socket"
          "network.target"
        ];
        description = "Minecraft Server Service, index:%i";
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
      targets.multi-user.wants =
        cfg.servers |> lib.mapAttrsToList (name: _: "minecraft-server@${name}.service");
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
