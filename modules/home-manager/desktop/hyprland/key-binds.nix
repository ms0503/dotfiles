{
  config,
  lib,
  theme,
  ...
}:
let
  inherit (config.ms0503) terminal;
  inherit (lib) mkIf mkLuaInline;
  better-movefocus = dir: ''
    function()
      local active_window = hl.get_active_window()
      if active_window.fullscreen ~= 0 then
        local monitors = hl.get_monitors()
        local suggested_monitors = lib.map(lib.filter(monitors, function(m)
          return not m.focused
        end), function(m)
          return m.activeWorkspace.id
        end)
        if 0 < #suggested_monitors then
          hl.dispatch(hl.dsp.focus({
            workspace = suggested_monitors[1]
          }))
        end
      else
        hl.dispatch(hl.dsp.focus({
          direction = '${dir}'
        }))
      end
    end
  '';
  cfg = config.ms0503.desktop.hyprland;
  cfgGui = config.ms0503.gui;
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
  ws-move = id: ''
    function()
      local monitor = hl.get_active_workspace().monitor.id
      hl.dispatch(hl.dsp.window.move({
        workspace = monitor * 10 + ${id |> builtins.toString}
      }))
    end
  '';
  ws-switch = id: ''
    function()
      local monitor = hl.get_active_workspace().monitor.id
      hl.dispatch(hl.dsp.focus({
        workspace = monitor * 10 + ${id |> builtins.toString}
      }))
    end
  '';
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
          (mkBind "${mainMod} + SHIFT + 0" (ws-move 10))
          (mkBind "${mainMod} + SHIFT + 1" (ws-move 1))
          (mkBind "${mainMod} + SHIFT + 2" (ws-move 2))
          (mkBind "${mainMod} + SHIFT + 3" (ws-move 3))
          (mkBind "${mainMod} + SHIFT + 4" (ws-move 4))
          (mkBind "${mainMod} + SHIFT + 5" (ws-move 5))
          (mkBind "${mainMod} + SHIFT + 6" (ws-move 6))
          (mkBind "${mainMod} + SHIFT + 7" (ws-move 7))
          (mkBind "${mainMod} + SHIFT + 8" (ws-move 8))
          (mkBind "${mainMod} + SHIFT + 9" (ws-move 9))
          (mkBind "${mainMod} + SHIFT + C" "hl.dsp.exec_cmd('uwsm app -- hyprpicker --autocopy')")
          (mkBind "${mainMod} + SHIFT + F" ''
            hl.dsp.window.float({
              action = 'toggle'
            })
          '')
          (mkBind "${mainMod} + SHIFT + M" "hl.dsp.exec_cmd('uwsm stop')")
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
          (mkBind "${mainMod} + SHIFT + S" ''hl.dsp.exec_cmd('uwsm app -- grimblast --notify copysave area "$HOME/Pictures/Screenshots/$(date +%Y-%m-%dT%H-%M-%S).png"')'')
          (mkBind "${mainMod} + 0" (ws-switch 10))
          (mkBind "${mainMod} + 1" (ws-switch 1))
          (mkBind "${mainMod} + 2" (ws-switch 2))
          (mkBind "${mainMod} + 3" (ws-switch 3))
          (mkBind "${mainMod} + 4" (ws-switch 4))
          (mkBind "${mainMod} + 5" (ws-switch 5))
          (mkBind "${mainMod} + 6" (ws-switch 6))
          (mkBind "${mainMod} + 7" (ws-switch 7))
          (mkBind "${mainMod} + 8" (ws-switch 8))
          (mkBind "${mainMod} + 9" (ws-switch 9))
          (mkBind "${mainMod} + Down" (better-movefocus "d"))
          (mkBind "${mainMod} + F" ''
            hl.dsp.window.fullscreen({
              action = 'toggle',
              mode = 'fullscreen',
              window = 'activewindow'
            })
          '')
          (mkBind "${mainMod} + L" "hl.dsp.exec_cmd('uwsm app -- swaylock -f -c ${theme.colors.bg}')")
          (mkBind "${mainMod} + Left" (better-movefocus "l"))
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
          (mkBind "${mainMod} + Period" "hl.dsp.exec_cmd('uwsm app -- wofi-emoji')")
          (mkBind "${mainMod} + Print" ''hl.dsp.exec_cmd('uwsm app -- grimblast --notify copysave screen "$HOME/Pictures/Screenshots/$(date +%Y-%m-%dT%H-%M-%S).png"')'')
          (mkBind "${mainMod} + Return" "hl.dsp.exec_cmd('uwsm app -- ${terminal}')")
          (mkBind "${mainMod} + Right" (better-movefocus "r"))
          (mkBind "${mainMod} + S" "hl.dsp.exec_cmd('uwsm app -- wofi --show drun --width 512px')")
          (mkBind "${mainMod} + Tab" ''
            function()
              local monitors = hl.get_monitors()
              local suggested_monitors = lib.map(lib.filter(monitors, function(m)
                return not m.focused
              end), function(m)
                return m.activeWorkspace.id
              end)
              if 0 < #suggested_monitors then
                hl.dispatch(hl.dsp.focus({
                  workspace = suggested_monitors[1]
                }))
              end
            end
          '')
          (mkBind "${mainMod} + Up" (better-movefocus "u"))
          (mkBind "${mainMod} + X" "hl.dsp.exec_cmd('uwsm app -- systemctl suspend')")
          (mkBind "${subMod} + SHIFT + Tab" ''
            hl.dsp.window.cycle_next({
              next = false
            })
          '')
          (mkBind "${subMod} + Tab" "hl.dsp.window.cycle_next()")
          (mkBind "Print" ''hl.dsp.exec_cmd('uwsm app -- grimblast --notify copysave output "$HOME/Pictures/Screenshots/$(date +%Y-%m-%dT%H-%M-%S).png"')'')
          (mkLockedBind "XF86AudioMute" "hl.dsp.exec_cmd('uwsm app -- pamixer -t')")
          (mkLockedBind "XF86AudioNext" "hl.dsp.exec_cmd('uwsm app -- playerctl next')")
          (mkLockedBind "XF86AudioPlay" "hl.dsp.exec_cmd('uwsm app -- playerctl play-pause')")
          (mkLockedBind "XF86AudioPrev" "hl.dsp.exec_cmd('uwsm app -- playerctl previous')")
          (mkLockedRepeatingBind "XF86AudioLowerVolume" "hl.dsp.exec_cmd('uwsm app -- pamixer -d 5')")
          (mkLockedRepeatingBind "XF86AudioRaiseVolume" "hl.dsp.exec_cmd('uwsm app -- pamixer -i 5')")
          (mkLockedRepeatingBind "XF86MonBrightnessDown" "hl.dsp.exec_cmd('uwsm app -- brightnessctl set 5%-')")
          (mkLockedRepeatingBind "XF86MonBrightnessUp" "hl.dsp.exec_cmd('uwsm app -- brightnessctl set +5%')")
          (mkMouseBind "${mainMod} + mouse:272" "hl.dsp.window.drag()")
          (mkMouseBind "${mainMod} + mouse:273" "hl.dsp.window.resize()")
        ];
      };
  };
}
