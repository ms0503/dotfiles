{
  config,
  lib,
  pkgs,
  utils,
  ...
}:
let
  inherit (lib)
    mkIf
    mkEnableOption
    mkOption
    types
    ;
  cfg = config.ms0503.server.nix-repo-updater;
  updater-script = pkgs.writeScriptBin "nix-repo-updater" ''
    #!${pkgs.bash}/bin/bash
    set -euo pipefail
    # argument must be 'owner/repo,branch,delay'
    [[ $1 =~ ^[^/]+/[^/]+,.+,[0-9]+$ ]] || exit 1
    IFS=, read -a args <<<"$1"
    sleep "''${args[2]}"
    ${pkgs.gh}/bin/gh api \
      -X POST \
      "repos/''${args[0]}/actions/workflows/update.yml/dispatches" \
      -f ref=''${args[1]}
  '';
in
{
  config = mkIf cfg.enable {
    systemd = {
      services."nix-repo-updater@" = {
        after = [
          "network.target"
        ];
        description = "ms0503's Nix Repositories Updater for %I";
        serviceConfig = {
          EnvironmentFile = "/var/lib/nix-repo-updater/.env";
          ExecStart = "${updater-script}/bin/nix-repo-updater %I";
          Type = "simple";
        };
      };
      targets =
        let
          getUnitNames =
            type:
            cfg.repos
            |> builtins.map (
              repo:
              let
                args = "${repo.owner}/${repo.repo},${repo.branch},${repo.delay |> builtins.toString}";
              in
              "nix-repo-updater@${args |> utils.escapeSystemdPath}.${type}"
            );
        in
        {
          multi-user.wants = getUnitNames "service";
          timers.wants = getUnitNames "timer";
        };
      timers."nix-repo-updater@" = {
        description = "Timer for nix-repo-updater";
        timerConfig = {
          AccuracySec = "1us";
          OnCalendar = "Sun *-*-* 00:00:00";
          Persistent = true;
          RandomizedDelaySec = "1s";
        };
      };
    };
    users = {
      groups.nix-repo-updater = { };
      users.nix-repo-updater = {
        createHome = true;
        description = "Nix Repositories Updater service user";
        group = "nix-repo-updater";
        home = "/var/lib/nix-repo-updater";
        isSystemUser = true;
      };
    };
  };
  options.ms0503.server.nix-repo-updater = {
    enable = mkEnableOption "Nix repositories updater";
    repos = mkOption {
      default = [ ];
      description = "List of repositories to update";
      type = types.listOf (
        types.submodule {
          options = {
            branch = mkOption {
              default = "main";
              description = "The branch of repository";
              example = "master";
              type = types.str;
            };
            delay = mkOption {
              default = 0;
              description = "Delay seconds from 00:00:00 (UTC) on Sunday";
              type = types.ints.between 0 86399; # 24h = 86400s
            };
            owner = mkOption {
              description = "The repository owner";
              example = "ms0503";
              type = types.str;
            };
            repo = mkOption {
              description = "The repository name";
              example = "dotfiles";
              type = types.str;
            };
          };
        }
      );
    };
  };
}
