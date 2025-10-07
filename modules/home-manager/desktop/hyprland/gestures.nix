{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.ms0503.desktop.hyprland;
  cfgGui = config.ms0503.gui;
in
{
  config = mkIf (cfgGui.enable && cfg.enable) {
    home.file."${config.xdg.configHome}/libinput-gestures.conf".text = ''
      gesture swipe up 3 wofi --show drun --width 512px
    '';
    wayland.windowManager.hyprland.settings.gesture = [
      "3, horizontal, scale: 0.5, workspace"
    ];
  };
}
