{ config, ... }:
{
  home.file."${config.xdg.configHome}/libinput-gestures.conf".text = ''
    gesture swipe up 3 wofi --show drun --width 512px
  '';
  wayland.windowManager.hyprland.settings.gesture = [
    "3, horizontal, scale: 0.5, workspace"
  ];
}
