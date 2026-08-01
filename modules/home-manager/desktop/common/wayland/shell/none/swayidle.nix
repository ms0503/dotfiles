{
  config,
  lib,
  pkgs,
  theme,
  ...
}:
let
  inherit (lib) mkIf mkLuaInline optionalAttrs;
  inherit (pkgs) writeScriptBin;
  inherit (theme) colors;
  cfg = config.ms0503.desktop.common.wayland;
  cfgHl = config.ms0503.desktop.hyprland;
  sleep = writeScriptBin "sleep" ''
    swayidle -w \
      before-sleep 'swaylock -f -c ${colors.bg}' \
      &
  '';
in
{
  config = mkIf (cfg.enable && cfg.shell == null) (
    {
      home.packages = with pkgs; [
        swayidle
      ];
    }
    // optionalAttrs cfgHl.enable {
      wayland.windowManager.hyprland.settings.on = [
        {
          _args = [
            "hyprland.start"
            (mkLuaInline ''
              function()
                hl.exec_cmd('uwsm app -- ${sleep}/bin/sleep')
              end
            '')
          ];
        }
      ];
    }
  );
}
