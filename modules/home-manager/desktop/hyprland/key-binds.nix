{
  config,
  lib,
  theme,
  ...
}:
let
  inherit (config.ms0503) terminal;
  inherit (lib) mkIf mkLuaInline;
  cfg = config.ms0503.desktop.hyprland;
  cfgGui = config.ms0503.gui;
  execCmd =
    cmd:
    "hl.dsp.exec_cmd(${
      cmd
      |> lib.generators.toLua {
        multiline = false;
      }
    })";
  mkBind = mkBindFn { };
  mkBindFn = options: key: action: {
    _args = [
      key
      (mkLuaInline action)
      options
    ];
  };
  mkLockedBind = mkBindFn {
    locked = true;
  };
  mkLockedRepeatingBind = mkBindFn {
    locked = true;
    repeating = true;
  };
  mkMouseBind = mkBindFn {
    mouse = true;
  };
in
{
  config = mkIf (cfgGui.enable && cfg.enable) {
    wayland.windowManager.hyprland.settings =
      let
        mainMod = "SUPER";
        subMod = "ALT";
      in
      {
        bind = [
          (mkBind "${mainMod} + CTRL + Left" ''
            hl.dsp.focus({
              workspace = 'm-1'
            })
          '')
          (mkBind "${mainMod} + CTRL + Right" ''
            hl.dsp.focus({
              workspace = 'm+1'
            })
          '')
          (mkBind "${mainMod} + SHIFT + 0" "tool.ws_move(10)")
          (mkBind "${mainMod} + SHIFT + 1" "tool.ws_move(1)")
          (mkBind "${mainMod} + SHIFT + 2" "tool.ws_move(2)")
          (mkBind "${mainMod} + SHIFT + 3" "tool.ws_move(3)")
          (mkBind "${mainMod} + SHIFT + 4" "tool.ws_move(4)")
          (mkBind "${mainMod} + SHIFT + 5" "tool.ws_move(5)")
          (mkBind "${mainMod} + SHIFT + 6" "tool.ws_move(6)")
          (mkBind "${mainMod} + SHIFT + 7" "tool.ws_move(7)")
          (mkBind "${mainMod} + SHIFT + 8" "tool.ws_move(8)")
          (mkBind "${mainMod} + SHIFT + 9" "tool.ws_move(9)")
          (mkBind "${mainMod} + SHIFT + C" (execCmd "uwsm app -- hyprpicker --autocopy"))
          (mkBind "${mainMod} + SHIFT + F" ''
            hl.dsp.window.float({
              action = 'toggle'
            })
          '')
          (mkBind "${mainMod} + SHIFT + M" (execCmd "uwsm stop"))
          (mkBind "${mainMod} + SHIFT + Q" ''
            hl.dsp.window.close({
              window = 'activewindow'
            })
          '')
          (mkBind "${mainMod} + SHIFT + Left" ''
            hl.dsp.window.move({
              workspace = 'm-1'
            })
          '')
          (mkBind "${mainMod} + SHIFT + Right" ''
            hl.dsp.window.move({
              workspace = 'm+1'
            })
          '')
          (mkBind "${mainMod} + SHIFT + S" (
            execCmd ''uwsm app -- grimblast --notify copysave area "$HOME/Pictures/Screenshots/$(date +%Y-%m-%dT%H-%M-%S).png"''
          ))
          (mkBind "${mainMod} + 0" "tool.ws_switch(10)")
          (mkBind "${mainMod} + 1" "tool.ws_switch(1)")
          (mkBind "${mainMod} + 2" "tool.ws_switch(2)")
          (mkBind "${mainMod} + 3" "tool.ws_switch(3)")
          (mkBind "${mainMod} + 4" "tool.ws_switch(4)")
          (mkBind "${mainMod} + 5" "tool.ws_switch(5)")
          (mkBind "${mainMod} + 6" "tool.ws_switch(6)")
          (mkBind "${mainMod} + 7" "tool.ws_switch(7)")
          (mkBind "${mainMod} + 8" "tool.ws_switch(8)")
          (mkBind "${mainMod} + 9" "tool.ws_switch(9)")
          (mkBind "${mainMod} + Down" "tool.better_movefocus('d')")
          (mkBind "${mainMod} + F" ''
            hl.dsp.window.fullscreen({
              action = 'toggle',
              mode = 'fullscreen',
              window = 'activewindow'
            })
          '')
          (mkBind "${mainMod} + L" (execCmd "uwsm app -- swaylock -f -c ${theme.colors.bg}"))
          (mkBind "${mainMod} + Left" "tool.better_movefocus('l')")
          (mkBind "${mainMod} + mouse_down" ''
            hl.dsp.focus({
              workspace = 'm+1'
            })
          '')
          (mkBind "${mainMod} + mouse_up" ''
            hl.dsp.focus({
              workspace = 'm-1'
            })
          '')
          (mkBind "${mainMod} + Period" (execCmd "uwsm app -- wofi-emoji"))
          (mkBind "${mainMod} + Print" (
            execCmd ''uwsm app -- grimblast --notify copysave screen "$HOME/Pictures/Screenshots/$(date +%Y-%m-%dT%H-%M-%S).png"''
          ))
          (mkBind "${mainMod} + Return" (execCmd "uwsm app -- ${terminal}"))
          (mkBind "${mainMod} + Right" "tool.better_movefocus('r')")
          (mkBind "${mainMod} + S" (execCmd "uwsm app -- wofi --show drun --width 512px"))
          (mkBind "${mainMod} + Tab" "tool.toggle_monitor()")
          (mkBind "${mainMod} + Up" "tool.better_movefocus('u')")
          (mkBind "${mainMod} + X" (execCmd "uwsm app -- systemctl suspend"))
          (mkBind "${subMod} + SHIFT + Tab" ''
            hl.dsp.window.cycle_next({
              next = false
            })
          '')
          (mkBind "${subMod} + Tab" "hl.dsp.window.cycle_next()")
          (mkBind "Print" (
            execCmd ''uwsm app -- grimblast --notify copysave output "$HOME/Pictures/Screenshots/$(date +%Y-%m-%dT%H-%M-%S).png"''
          ))
          (mkLockedBind "XF86AudioMute" (execCmd "uwsm app -- pamixer -t"))
          (mkLockedBind "XF86AudioNext" (execCmd "uwsm app -- playerctl next"))
          (mkLockedBind "XF86AudioPlay" (execCmd "uwsm app -- playerctl play-pause"))
          (mkLockedBind "XF86AudioPrev" (execCmd "uwsm app -- playerctl previous"))
          (mkLockedRepeatingBind "XF86AudioLowerVolume" (execCmd "uwsm app -- pamixer -d 5"))
          (mkLockedRepeatingBind "XF86AudioRaiseVolume" (execCmd "uwsm app -- pamixer -i 5"))
          (mkLockedRepeatingBind "XF86MonBrightnessDown" (execCmd "uwsm app -- brightnessctl set 5%-"))
          (mkLockedRepeatingBind "XF86MonBrightnessUp" (execCmd "uwsm app -- brightnessctl set +5%"))
          (mkMouseBind "${mainMod} + mouse:272" "hl.dsp.window.drag()")
          (mkMouseBind "${mainMod} + mouse:273" "hl.dsp.window.resize()")
        ];
      };
  };
}
