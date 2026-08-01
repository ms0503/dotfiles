{ config, lib, ... }:
let
  inherit (lib) mkIf mkLuaInline optionalAttrs;
  cfg = config.ms0503.desktop.common.wayland;
  cfgHl = config.ms0503.desktop.hyprland;
in
{
  config = mkIf (cfg.enable && cfg.shell == null) {
    wayland = optionalAttrs cfgHl.enable {
      windowManager.hyprland.settings.on = [
        {
          _args = [
            "hyprland.start"
            (mkLuaInline ''
              function()
                hl.exec_cmd('uwsm app -- blueman-applet')
              end
            '')
          ];
        }
      ];
    };
  };
}
