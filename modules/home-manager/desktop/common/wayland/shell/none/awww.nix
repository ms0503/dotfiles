{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkLuaInline optionalAttrs;
  cfg = config.ms0503.desktop.common.wayland;
  cfgHl = config.ms0503.desktop.hyprland;
in
{
  config = mkIf (cfg.enable && cfg.shell == null) {
    home.packages = with pkgs; [
      awww
    ];
    wayland = optionalAttrs cfgHl.enable {
      windowManager.hyprland.settings.on = [
        {
          _args = [
            "hyprland.start"
            (mkLuaInline ''
              function()
                hl.exec_cmd('uwsm app -- awww-daemon')
                hl.exec_cmd('uwsm app -- awww img ~/.config/hypr/wallpaper/bg.webp')
              end
            '')
          ];
        }
      ];
    };
  };
}
