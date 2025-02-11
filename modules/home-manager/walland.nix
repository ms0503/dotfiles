{
  config,
  lib,
  myLib,
  myPkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf mkOption;
  cfg = config.ms0503.walland;
  types = lib.types // myLib.types;
in
{
  config = mkIf cfg.enable {
    systemd.user = {
      services.walland = {
        Service = {
          ExecStart = "${myPkgs.walland}/bin/walland -b ${cfg.backend} -s ${cfg.source}";
          Type = "oneshot";
        };
        Unit.Description = "Set as wallpaper on Wayland the picture of the day of different sources using hyprpaper or other backends";
      };
      timers.walland = {
        Install.WantedBy = [
          "timers.target"
        ];
        Timer = {
          OnCalendar = cfg.schedule;
          Persistent = true;
          Unit = "walland.service";
        };
      };
    };
  };
  options.ms0503.walland = {
    backend = mkOption {
      description = "Wallpaper backend";
      type = types.walland.backends;
    };
    enable = mkEnableOption "Walland";
    schedule = mkOption {
      default = "hourly";
      description = "Schedule of changing background";
      type = types.str;
    };
    source = mkOption {
      default = "random";
      description = "Wallpaper source";
      type = types.walland.sources;
    };
  };
}
