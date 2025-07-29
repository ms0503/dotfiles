{ config, ... }:
{
  home.file."${config.xdg.configHome}/libinput-gestures.conf".text = ''
    gesture swipe up 3 wofi --show drun --width 512px
  '';
  wayland.windowManager.hyprland.settings.gestures = {
    workspace_swipe = true;
    workspace_swipe_fingers = 3;
  };
}
