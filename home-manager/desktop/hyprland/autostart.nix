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
  sleep = writeScriptBin "sleep.sh" ''
    swayidle -w \
      after-resume 'systemctl --user start libinput-gestures' \
      before-sleep 'systemctl --user stop libinput-gestures' \
      before-sleep 'swaylock -f -c ${colors.bg}' \
      &
  '';
in
{
  wayland.windowManager.hyprland.settings.exec-once = [
    "dbus-update-activation-environment --systemd --all"
    "systemctl --user start hyprland-session.target"
    "${sleep}/bin/sleep.sh"
    "blueman-applet"
    "nm-applet"
    "waybar"
    "swww init && swww img ~/.config/hypr/wallpaper/bg.jpg"
    "fcitx5 -D"
    "steam -silent"
    "[workspace 1 silent] microsoft-edge-dev"
    "[workspace 2 silent] ${terminal}"
    "[workspace 3 silent] discordcanary"
  ];
}
