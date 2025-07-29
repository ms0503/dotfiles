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
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "dbus-update-activation-environment --systemd --all"
      "systemctl --user start hyprland-session.target"
      "libinput-gestures"
      "${sleep}/bin/sleep"
      "blueman-applet"
      "nm-applet"
      "${waybar-wrapper}/bin/waybar-wrapper"
      "swww-daemon"
      "swww img ~/.config/hypr/wallpaper/bg.webp"
      "fcitx5 -D"
      "steam -silent"
      "[workspace 1 silent] microsoft-edge-dev"
      "[workspace 2 silent] ${terminal}"
      "[workspace 3 silent] discordcanary"
    ];
    windowrule = [
      "workspace 3 silent, class:discord"
    ];
  };
}
