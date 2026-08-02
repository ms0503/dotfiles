args@{
  config,
  inputs',
  lib,
  theme,
  ...
}:
let
  inherit (lib)
    mkIf
    mkLuaInline
    mkOption
    optionalAttrs
    types
    ;
  cfg = config.ms0503.desktop.common.wayland.noctalia;
  cfgHl = config.ms0503.desktop.hyprland;
  cfgWl = config.ms0503.desktop.common.wayland;
in
{
  config = mkIf (cfgWl.enable && cfgWl.shell == "noctalia") {
    assertions = [
      {
        assertion = (cfg.monitors |> builtins.attrNames |> builtins.length) == 0;
        message = "ms0503.desktop.common.wayland.noctalia.monitors must have at least one definition of monitor";
      }
    ];
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
    wayland = optionalAttrs cfgHl.enable {
      windowManager.hyprland.settings.on = [
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
    };
    xdg.configFile."noctalia/palettes/MyPalette.json".text = theme.noctalia |> builtins.toJSON;
  };
  options.ms0503.desktop.common.wayland.noctalia.monitors = mkOption {
    default = { };
    description = "Monitor definitions. (key is wayland connector name)";
    type = types.attrsOf (
      types.submodule {
        options = {
          height = mkOption {
            description = "Monitor height in px.";
            type = types.ints.positive;
          };
          width = mkOption {
            description = "Monitor width in px.";
            type = types.ints.positive;
          };
        };
      }
    );
  };
}
