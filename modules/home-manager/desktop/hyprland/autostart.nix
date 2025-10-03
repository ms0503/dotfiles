{
  config,
  lib,
  pkgs,
  theme,
  ...
}:
let
  inherit (config.ms0503) terminal;
  inherit (lib) mkIf;
  inherit (pkgs) writeScriptBin;
  inherit (theme) colors;
  cfgGUI = config.ms0503.gui;
  cfgHyprland = config.ms0503.desktop.hyprland;
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
  config = mkIf (cfgGUI.enable && cfgHyprland.enable) {
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
        "[workspace ${builtins.toString (cfgHyprland.startup-monitor * 10 + 1)} silent] microsoft-edge-dev"
        "[workspace ${builtins.toString (cfgHyprland.startup-monitor * 10 + 2)} silent] ${terminal}"
        "[workspace ${builtins.toString (cfgHyprland.startup-monitor * 10 + 3)} silent] discordcanary"
      ];
      windowrule = [
        "workspace ${builtins.toString (cfgHyprland.startup-monitor * 10 + 3)} silent, class:discord"
      ];
    };
  };
}
