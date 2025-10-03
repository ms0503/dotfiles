{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfgGUI = config.ms0503.gui;
  cfgHyprland = config.ms0503.desktop.hyprland;
in
{
  config = mkIf (cfgGUI.enable && cfgHyprland.enable) {
    home.file."${config.xdg.configHome}/libinput-gestures.conf".text = ''
      gesture swipe up 3 wofi --show drun --width 512px
    '';
    wayland.windowManager.hyprland.settings.gesture = [
      "3, horizontal, scale: 0.5, workspace"
    ];
  };
}
