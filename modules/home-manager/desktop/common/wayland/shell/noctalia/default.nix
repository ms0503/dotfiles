{ config, lib, ... }:
let
  inherit (lib) mkIf mkLuaInline optionalAttrs;
  cfg = config.ms0503.desktop.common.wayland;
  cfgHl = config.ms0503.desktop.hyprland;
in
{
  config = mkIf (cfg.enable && cfg.shell == "noctalia") (
    {
      programs.noctalia = {
        enable = true;
        settings = import ./settings.nix;
      };
    }
    // optionalAttrs cfgHl.enable {
      wayland.windowManager.hyprland.settings.on = [
        {
          _args = [
            "hyprland.start"
            (mkLuaInline ''
              function()
                hl.exec_cmd('uwsm app -- noctalia')
              end
            '')
          ];
        }
      ];
    }
  );
}
