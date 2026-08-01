args@{
  config,
  inputs',
  lib,
  theme,
  ...
}:
let
  inherit (lib) mkIf mkLuaInline optionalAttrs;
  cfg = config.ms0503.desktop.common.wayland;
  cfgHl = config.ms0503.desktop.hyprland;
in
{
  config = mkIf (cfg.enable && cfg.shell == "noctalia") (
    {
      home = {
        packages = with inputs'.hyprqt6engine.packages; [
          hyprqt6engine
        ];
        sessionVariables.QT_QPA_PLATFORMTHEME = "hyprqt6engine";
      };
      programs.noctalia = {
        enable = true;
        settings = import ./settings args;
      };
      xdg.configFile."noctalia/palettes/MyPalette.json".text = theme.noctalia |> builtins.toJSON;
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
