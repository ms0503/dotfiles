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
  better-movefocus = pkgs.writeScriptBin "better-movefocus" ''
    if [[ "$(hyprctl activewindow -j | jq .fullscreen)" = "true" ]]; then
      hyprctl monitors -j | jq 'map(select(.focused | not).activeWorkspace.id)[0]' | xargs hyprctl dispatch workspace
    else
      hyprctl dispatch movefocus "$1"
    fi
  '';
  cfg = config.ms0503.desktop.hyprland;
  cfgGui = config.ms0503.gui;
  toggle-monitor = pkgs.writeScriptBin "toggle-monitor" ''
    hyprctl monitors -j | jq 'map(select(.focused | not).activeWorkspace.id)[0]' | xargs hyprctl dispatch workspace
  '';
  ws-move = pkgs.writeScriptBin "ws-move" ''
    monitor=$(hyprctl activeworkspace -j | jq .monitorID)
    hyprctl dispatch movetoworkspace $((monitor * 10 + $1))
  '';
  ws-switch = pkgs.writeScriptBin "ws-switch" ''
    monitor=$(hyprctl activeworkspace -j | jq .monitorID)
    hyprctl dispatch workspace $((monitor * 10 + $1))
  '';
in
{
  config = mkIf (cfgGui.enable && cfg.enable) {
    wayland.windowManager.hyprland.settings = {
      "$mainMod" = "SUPER";
      "$subMod" = "ALT";
      "$term" = "uwsm app -- ${terminal}";
      bind = [
        "$mainMod CTRL, left, workspace, m-1"
        "$mainMod CTRL, right, workspace, m+1"
        "$mainMod SHIFT, 0, exec, uwsm app -- ${ws-move}/bin/ws-move 10"
        "$mainMod SHIFT, 1, exec, uwsm app -- ${ws-move}/bin/ws-move 1"
        "$mainMod SHIFT, 2, exec, uwsm app -- ${ws-move}/bin/ws-move 2"
        "$mainMod SHIFT, 3, exec, uwsm app -- ${ws-move}/bin/ws-move 3"
        "$mainMod SHIFT, 4, exec, uwsm app -- ${ws-move}/bin/ws-move 4"
        "$mainMod SHIFT, 5, exec, uwsm app -- ${ws-move}/bin/ws-move 5"
        "$mainMod SHIFT, 6, exec, uwsm app -- ${ws-move}/bin/ws-move 6"
        "$mainMod SHIFT, 7, exec, uwsm app -- ${ws-move}/bin/ws-move 7"
        "$mainMod SHIFT, 8, exec, uwsm app -- ${ws-move}/bin/ws-move 8"
        "$mainMod SHIFT, 9, exec, uwsm app -- ${ws-move}/bin/ws-move 9"
        "$mainMod SHIFT, F, togglefloating"
        "$mainMod SHIFT, M, exit"
        "$mainMod SHIFT, Q, exec, uwsm app -- hyprctl dispatch killactive"
        "$mainMod SHIFT, c, exec, uwsm app -- hyprpicker --autocopy"
        "$mainMod SHIFT, left, movetoworkspace, m-1"
        "$mainMod SHIFT, right, movetoworkspace, m+1"
        "$mainMod SHIFT, s, exec, uwsm app -- grimblast --notify copysave area \"$HOME/Pictures/Screenshots/$(date +%Y-%m-%d' '%H-%M-%S).png\""
        "$mainMod, 0, exec, uwsm app -- ${ws-switch}/bin/ws-switch 10"
        "$mainMod, 1, exec, uwsm app -- ${ws-switch}/bin/ws-switch 1"
        "$mainMod, 2, exec, uwsm app -- ${ws-switch}/bin/ws-switch 2"
        "$mainMod, 3, exec, uwsm app -- ${ws-switch}/bin/ws-switch 3"
        "$mainMod, 4, exec, uwsm app -- ${ws-switch}/bin/ws-switch 4"
        "$mainMod, 5, exec, uwsm app -- ${ws-switch}/bin/ws-switch 5"
        "$mainMod, 6, exec, uwsm app -- ${ws-switch}/bin/ws-switch 6"
        "$mainMod, 7, exec, uwsm app -- ${ws-switch}/bin/ws-switch 7"
        "$mainMod, 8, exec, uwsm app -- ${ws-switch}/bin/ws-switch 8"
        "$mainMod, 9, exec, uwsm app -- ${ws-switch}/bin/ws-switch 9"
        "$mainMod, F, fullscreen"
        "$mainMod, Print, exec, uwsm app -- grimblast --notify copysave screen \"$HOME/Pictures/Screenshots/$(date +%Y-%m-%d'T'%H-%M-%S).png\""
        "$mainMod, Return, exec, uwsm app -- hyprctl dispatch exec ${terminal}"
        "$mainMod, Tab, exec, uwsm app -- ${toggle-monitor}/bin/toggle-monitor"
        "$mainMod, down, exec, uwsm app -- ${better-movefocus}/bin/better-movefocus d"
        "$mainMod, l, exec, uwsm app -- swaylock -f -c ${theme.colors.bg}"
        "$mainMod, left, exec, uwsm app -- ${better-movefocus}/bin/better-movefocus l"
        "$mainMod, mouse_down, workspace, m-1"
        "$mainMod, mouse_up, workspace, m+1"
        "$mainMod, period, exec, uwsm app -- wofi-emoji"
        "$mainMod, right, exec, uwsm app -- ${better-movefocus}/bin/better-movefocus r"
        "$mainMod, s, exec, uwsm app -- wofi --show drun --width 512px"
        "$mainMod, up, exec, uwsm app -- ${better-movefocus}/bin/better-movefocus u"
        "$mainMod, x, exec, uwsm app -- systemctl suspend"
        "$subMod SHIFT, Tab, cyclenext, prev"
        "$subMod, Tab, cyclenext"
        ", Print, exec, uwsm app -- grimblast --notify copysave output \"$HOME/Pictures/Screenshots/$(date +%Y-%m-%d'T'%H-%M-%S).png\""
      ];
      bindl = [
        ", XF86AudioMute, exec, uwsm app -- pamixer -t"
        ", XF86AudioNext, exec, uwsm app -- playerctl next"
        ", XF86AudioPlay, exec, uwsm app -- playerctl play-pause"
        ", XF86AudioPrev, exec, uwsm app -- playerctl previous"
      ];
      bindle = [
        ", XF86AudioLowerVolume, exec, uwsm app -- pamixer -d 5"
        ", XF86AudioRaiseVolume, exec, uwsm app -- pamixer -i 5"
        ", XF86MonBrightnessDown, exec, uwsm app -- brightnessctl set 5%-"
        ", XF86MonBrightnessUp, exec, uwsm app -- brightnessctl set +5%"
      ];
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
