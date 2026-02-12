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
  cfg = config.ms0503.desktop.hyprland;
  cfgGui = config.ms0503.gui;
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
  config = mkIf (cfgGui.enable && cfg.enable) {
    wayland.windowManager.hyprland.settings = {
      exec-once = [
        "uwsm app -- dbus-update-activation-environment --systemd --all"
        "uwsm app -- systemctl --user start hyprland-session.target"
        "uwsm app -- libinput-gestures"
        "uwsm app -- ${sleep}/bin/sleep"
        "uwsm app -- blueman-applet"
        "uwsm app -- nm-applet"
        "uwsm app -- ${waybar-wrapper}/bin/waybar-wrapper"
        "uwsm app -- swww-daemon"
        "uwsm app -- swww img ~/.config/hypr/wallpaper/bg.webp"
        "uwsm app -- fcitx5 -D"
        "uwsm app -- steam -silent"
        "[workspace ${
          builtins.toString (cfg.startup-monitor * 10 + 1)
        } silent] uwsm app -- microsoft-edge-dev"
        "[workspace ${builtins.toString (cfg.startup-monitor * 10 + 2)} silent] uwsm app -- ${terminal}"
        "[workspace ${builtins.toString (cfg.startup-monitor * 10 + 3)} silent] uwsm app -- discordcanary"
      ];
      windowrule = [
        "match:class discord, workspace ${builtins.toString (cfg.startup-monitor * 10 + 3)} silent"
      ];
    };
  };
}
