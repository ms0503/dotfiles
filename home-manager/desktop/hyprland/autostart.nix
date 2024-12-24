{ writeScriptBin, ... }:
let
  sleep = writeScriptBin "sleep.sh" ''
    swayidle -w before-sleep 'swaylock -f -c 000000' &
  '';
in
[
  "${sleep}/bin/sleep.sh"
  "blueman-applet"
  "nm-applet"
  "waybar"
  "swww init && swww img ~/.config/hypr/wallpaper/bg.jpg"
  "fcitx5 -D"
  "discordcanary --start-minimized"
  "steam -silent"
]
# vim: et sts=2 sw=2 ts=2
