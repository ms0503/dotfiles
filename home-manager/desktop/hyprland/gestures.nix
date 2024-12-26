{ config, ... }:
{
  home.file."${config.xdg.configHome}/libinput-gestures.conf".text = ''
    gesture swipe left 3 hyprctl dispatch workspace m-1
    gesture swipe right 3 hyprctl dispatch workspace m+1
    gesture swipe up 3 wofi --show drun --width 512px
  '';
}
# vim: et sts=2 sw=2 ts=2
