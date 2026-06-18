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
in
{
  config = mkIf (cfgGui.enable && cfg.enable) {
    home = {
      packages =
        (with pkgs; [
          awww
          brightnessctl
          grimblast
          hyprcursor
          hyprpicker
          pamixer
          playerctl
          wev
          wf-recorder
          wl-clipboard
          wlogout
        ])
        ++ [
          inputs'.hyprsome.packages.default
        ];
      sessionVariables.ELECTRON_OZONE_PLATFORM_HINT = "auto";
    };
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
      "uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
    };
  };
  imports = [
    ./autostart.nix
    ./dunst.nix
    ./gestures.nix
    ./key-binds.nix
    ./settings.nix
    ./swaylock.nix
    ./waybar.nix
    ./wofi.nix
  ];
  options.ms0503.desktop.hyprland.startup-monitor = mkOption {
    description = "Monitor ID that is used by startup";
    type = types.ints.unsigned;
  };
}
