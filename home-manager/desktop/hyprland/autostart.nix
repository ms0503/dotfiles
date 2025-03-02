{
  config,
  pkgs,
  theme,
  ...
}:
let
  inherit (config.ms0503) terminal;
  inherit (pkgs) writeScriptBin;
  inherit (theme) colors;
  sleep = writeScriptBin "sleep" ''
    swayidle -w \
      after-resume 'systemctl --user start libinput-gestures' \
      before-sleep 'systemctl --user stop libinput-gestures' \
      before-sleep 'swaylock -f -c ${colors.bg}' \
      &
  '';
  waybar-wrapper = writeScriptBin "waybar-wrapper" ''
    while :; do
      waybar
      sleep 5
    done
  '';
in
{
  wayland.windowManager.hyprland.settings.exec-once = [
    "dbus-update-activation-environment --systemd --all"
    "systemctl --user start hyprland-session.target"
    "${sleep}/bin/sleep"
    "blueman-applet"
    "nm-applet"
    "${waybar-wrapper}/bin/waybar-wrapper"
    "swww init && swww img ~/.config/hypr/wallpaper/bg.jpg"
    "fcitx5 -D"
    "steam -silent"
    "[workspace 1 silent] microsoft-edge-dev"
    "[workspace 2 silent] ${terminal}"
    "[workspace 3 silent] discordcanary"
  ];
}
