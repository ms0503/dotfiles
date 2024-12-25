{ pkgs, ... }:
let
  better-movefocus = pkgs.writeScriptBin "better-movefocus" ''
    if [[ "$(hyprctl activewindow -j | jq .fullscreen)" = "true" ]]; then
      hyprctl monitors -j | jq 'map(select(.focused | not).activeWorkspace.id)[0]' | xargs hyprctl dispatch workspace
    else
      hyprctl dispatch movefocus "$1"
    fi
  '';
  close-window = pkgs.writeScriptBin "close-window" ''
    hyprctl dispatch killactive
    sleep 0.01
    window_count=$(hyprctl activeworkspace -j | jq .windows)
    is_fullscreen=$(hyprctl activeworkspace -j | jq .hasfullscreen)
    if (( window_count == 1 )) && [[ $is_fullscreen = "false" ]]; then
      hyprctl dispatch fullscreen
    elif (( 1 < window_count )) && [[ $is_fullscreen = "true" ]]; then
      hyprctl dispatch fullscreen
    fi
  '';
  open-terminal = pkgs.writeScriptBin "open-terminal" ''
    window_count=$(hyprctl activeworkspace -j | jq .windows)
    is_fullscreen=$(hyprctl activeworkspace -j | jq .hasfullscreen)
    hyprctl dispatch exec wezterm
    if (( window_count == 0 )) && [[ $is_fullscreen = "false" ]]; then
      sleep 0.1
      hyprctl dispatch fullscreen
    elif (( 1 <= window_count )) && [[ $is_fullscreen = "true" ]]; then
      hyprctl dispatch fullscreen
    fi
  '';
  open-wofi = pkgs.writeScriptBin "open-wofi" ''
    window_count=$(hyprctl activeworkspace -j | jq .windows)
    is_fullscreen=$(hyprctl activeworkspace -j | jq .hasfullscreen)
    wofi --show drun --width 512px
    if (( window_count == 0 )) && [[ $is_fullscreen = "false" ]]; then
      sleep 0.1
      hyprctl dispatch fullscreen
    elif (( 1 <= window_count )) && [[ $is_fullscreen = "true" ]]; then
      hyprctl dispatch fullscreen
    fi
  '';
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
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";
    "$subMod" = "ALT";
    "$term" = "wezterm";
    bind = [
      "$mainMod CTRL, left, workspace, m-1"
      "$mainMod CTRL, right, workspace, m+1"
      "$mainMod SHIFT, 0, exec, ${ws-move}/bin/ws-move 10"
      "$mainMod SHIFT, 1, exec, ${ws-move}/bin/ws-move 1"
      "$mainMod SHIFT, 2, exec, ${ws-move}/bin/ws-move 2"
      "$mainMod SHIFT, 3, exec, ${ws-move}/bin/ws-move 3"
      "$mainMod SHIFT, 4, exec, ${ws-move}/bin/ws-move 4"
      "$mainMod SHIFT, 5, exec, ${ws-move}/bin/ws-move 5"
      "$mainMod SHIFT, 6, exec, ${ws-move}/bin/ws-move 6"
      "$mainMod SHIFT, 7, exec, ${ws-move}/bin/ws-move 7"
      "$mainMod SHIFT, 8, exec, ${ws-move}/bin/ws-move 8"
      "$mainMod SHIFT, 9, exec, ${ws-move}/bin/ws-move 9"
      "$mainMod SHIFT, F, togglefloating"
      "$mainMod SHIFT, M, exit"
      "$mainMod SHIFT, Q, exec, ${close-window}/bin/close-window"
      "$mainMod SHIFT, c, exec, hyprpicker --autocopy"
      "$mainMod SHIFT, left, movetoworkspace, m-1"
      "$mainMod SHIFT, right, movetoworkspace, m+1"
      "$mainMod SHIFT, s, exec, grimblast --notify copysave area \"$HOME/Pictures/スクリーンショット/Screenshot from $(date +%Y-%m-%d' '%H-%M-%S).png\""
      "$mainMod, 0, exec, ${ws-switch}/bin/ws-switch 10"
      "$mainMod, 1, exec, ${ws-switch}/bin/ws-switch 1"
      "$mainMod, 2, exec, ${ws-switch}/bin/ws-switch 2"
      "$mainMod, 3, exec, ${ws-switch}/bin/ws-switch 3"
      "$mainMod, 4, exec, ${ws-switch}/bin/ws-switch 4"
      "$mainMod, 5, exec, ${ws-switch}/bin/ws-switch 5"
      "$mainMod, 6, exec, ${ws-switch}/bin/ws-switch 6"
      "$mainMod, 7, exec, ${ws-switch}/bin/ws-switch 7"
      "$mainMod, 8, exec, ${ws-switch}/bin/ws-switch 8"
      "$mainMod, 9, exec, ${ws-switch}/bin/ws-switch 9"
      "$mainMod, F, fullscreen"
      "$mainMod, Print, exec, grimblast --notify copysave output \"$HOME/Pictures/スクリーンショット/Screenshot from $(date +%Y-%m-%d' '%H-%M-%S).png\""
      "$mainMod, Return, exec, ${open-terminal}/bin/open-terminal"
      "$mainMod, Tab, exec, ${toggle-monitor}/bin/toggle-monitor"
      "$mainMod, down, exec, ${better-movefocus}/bin/better-movefocus d"
      "$mainMod, l, exec, swaylock-fancy -d"
      "$mainMod, left, exec, ${better-movefocus}/bin/better-movefocus l"
      "$mainMod, mouse_down, workspace, m+1"
      "$mainMod, mouse_up, workspace, m-1"
      "$mainMod, period, exec, wofi-emoji"
      "$mainMod, right, exec, ${better-movefocus}/bin/better-movefocus r"
      "$mainMod, s, exec, ${open-wofi}/bin/open-wofi"
      "$mainMod, up, exec, ${better-movefocus}/bin/better-movefocus u"
      "$mainMod, x, exec, systemctl suspend"
      "$subMod SHIFT, Tab, cyclenext, prev"
      "$subMod, Tab, cyclenext"
      ", Print, exec, grimblast --notify copy output"
    ];
    bindl = [
      ", XF86AudioMute, exec, pamixer -t"
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
    ];
    bindle = [
      ", XF86AudioLowerVolume, exec, pamixer -d 10"
      ", XF86AudioRaiseVolume, exec, pamixer -i 10"
      ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
      ", XF86MonBrightnessUp, exec, brightnessctl set +10%"
    ];
    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];
  };
}
# vim: et sts=2 sw=2 ts=2
