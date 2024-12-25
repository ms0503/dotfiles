{ writeScriptBin, ... }: { colors, ... }:
let
  sleep = writeScriptBin "sleep.sh" ''
    swayidle -w before-sleep 'swaylock -f -c ${colors.bg}' &
  '';
in
[
  "dbus-update-activation-environment --systemd --all"
  "systemctl --user start hyprland-session.target"
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
