{
  config,
  inputs',
  isNixOS,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mergeAttrsList
    mkIf
    mkLuaInline
    mkOption
    optionalAttrs
    types
    ;
  cfg = config.ms0503.desktop.hyprland;
  cfgGui = config.ms0503.gui;
  cfgWl = config.ms0503.wayland;
in
{
  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = cfgGui.enable;
        message = "ms0503.gui.enable must be true";
      }
      {
        assertion = cfgWl.enable;
        message = "ms0503.wayland.enable must be true";
      }
    ];
    home.packages = builtins.concatLists [
      (with pkgs; [
        grimblast
        hyprcursor
        hyprpicker
      ])
      [
        inputs'.hyprsome.packages.default
      ]
    ];
    wayland.windowManager.hyprland = mergeAttrsList [
      {
        configType = "lua";
        enable = true;
        settings = {
          lib._var = mkLuaInline "require('lib')";
          tool._var = mkLuaInline "require('tool')";
        };
        systemd.enable = false;
        xwayland.enable = true;
      }
      (optionalAttrs isNixOS {
        package = null;
        portalPackage = null;
      })
    ];
    xdg.configFile = {
      "hypr/lib.lua".source = ./lib.lua;
      "hypr/tool.lua".source = ./tool.lua;
    };
  };
  imports = [
    ../common/wayland
    ./autostart.nix
    ./gestures.nix
    ./key-binds.nix
    ./settings.nix
  ];
  options.ms0503.desktop.hyprland.startup-monitor = mkOption {
    description = "Monitor ID that is used by startup";
    type = types.ints.unsigned;
  };
}
