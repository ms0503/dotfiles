{
  config,
  lib,
  theme,
  ...
}:
let
  inherit (config.ms0503) terminal;
  inherit (lib) mkIf mkLuaInline;
  better-movefocus =
    dir:
    mkLuaInline ''
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
  toggle-monitor = mkLuaInline ''
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
  '';
  ws-move =
    id:
    mkLuaInline ''
      function()
        local monitor = hl.get_active_workspace().monitor.id
        hl.dispatch(hl.dsp.window.move({
          workspace = monitor * 10 + ${id |> builtins.toString}
        }))
      end
    '';
  ws-switch =
    id:
    mkLuaInline ''
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
          {
            _args = [
              "${mainMod} + CTRL + Left"
              (mkLuaInline ''
                hl.dsp.focus({
                  workspace = 'm-1'
                })
              '')
            ];
          }
          {
            _args = [
              "${mainMod} + CTRL + Right"
              (mkLuaInline ''
                hl.dsp.focus({
                  workspace = 'm+1'
                })
              '')
            ];
          }
          {
            _args = [
              "${mainMod} + SHIFT + 0"
              (ws-move 10)
            ];
          }
          {
            _args = [
              "${mainMod} + SHIFT + 1"
              (ws-move 1)
            ];
          }
          {
            _args = [
              "${mainMod} + SHIFT + 2"
              (ws-move 2)
            ];
          }
          {
            _args = [
              "${mainMod} + SHIFT + 3"
              (ws-move 3)
            ];
          }
          {
            _args = [
              "${mainMod} + SHIFT + 4"
              (ws-move 4)
            ];
          }
          {
            _args = [
              "${mainMod} + SHIFT + 5"
              (ws-move 5)
            ];
          }
          {
            _args = [
              "${mainMod} + SHIFT + 6"
              (ws-move 6)
            ];
          }
          {
            _args = [
              "${mainMod} + SHIFT + 7"
              (ws-move 7)
            ];
          }
          {
            _args = [
              "${mainMod} + SHIFT + 8"
              (ws-move 8)
            ];
          }
          {
            _args = [
              "${mainMod} + SHIFT + 9"
              (ws-move 9)
            ];
          }
          {
            _args = [
              "${mainMod} + SHIFT + C"
              (mkLuaInline "hl.dsp.exec_cmd('uwsm app -- hyprpicker --autocopy')")
            ];
          }
          {
            _args = [
              "${mainMod} + SHIFT + F"
              (mkLuaInline ''
                hl.dsp.window.float({
                  action = 'toggle'
                })
              '')
            ];
          }
          {
            _args = [
              "${mainMod} + SHIFT + M"
              (mkLuaInline "hl.dsp.exit()")
            ];
          }
          {
            _args = [
              "${mainMod} + SHIFT + Q"
              (mkLuaInline ''
                hl.dsp.window.close({
                  window = 'activewindow'
                })
              '')
            ];
          }
          {
            _args = [
              "${mainMod} + SHIFT + Left"
              (mkLuaInline ''
                hl.dsp.window.move({
                  workspace = 'm-1'
                })
              '')
            ];
          }
          {
            _args = [
              "${mainMod} + SHIFT + Right"
              (mkLuaInline ''
                hl.dsp.window.move({
                  workspace = 'm+1'
                })
              '')
            ];
          }
          {
            _args = [
              "${mainMod} + SHIFT + S"
              (mkLuaInline ''hl.dsp.exec_cmd('uwsm app -- grimblast --notify copysave area "$HOME/Pictures/Screenshots/$(date +%Y-%m-%dT%H-%M-%S).png"')'')
            ];
          }
          {
            _args = [
              "${mainMod} + 0"
              (ws-switch 10)
            ];
          }
          {
            _args = [
              "${mainMod} + 1"
              (ws-switch 1)
            ];
          }
          {
            _args = [
              "${mainMod} + 2"
              (ws-switch 2)
            ];
          }
          {
            _args = [
              "${mainMod} + 3"
              (ws-switch 3)
            ];
          }
          {
            _args = [
              "${mainMod} + 4"
              (ws-switch 4)
            ];
          }
          {
            _args = [
              "${mainMod} + 5"
              (ws-switch 5)
            ];
          }
          {
            _args = [
              "${mainMod} + 6"
              (ws-switch 6)
            ];
          }
          {
            _args = [
              "${mainMod} + 7"
              (ws-switch 7)
            ];
          }
          {
            _args = [
              "${mainMod} + 8"
              (ws-switch 8)
            ];
          }
          {
            _args = [
              "${mainMod} + 9"
              (ws-switch 9)
            ];
          }
          {
            _args = [
              "${mainMod} + Down"
              (better-movefocus "d")
            ];
          }
          {
            _args = [
              "${mainMod} + F"
              (mkLuaInline ''
                hl.dsp.window.fullscreen({
                  action = 'toggle',
                  mode = 'fullscreen',
                  window = 'activewindow'
                })
              '')
            ];
          }
          {
            _args = [
              "${mainMod} + L"
              (mkLuaInline "hl.dsp.exec_cmd('uwsm app -- swaylock -f -c ${theme.colors.bg}')")
            ];
          }
          {
            _args = [
              "${mainMod} + Left"
              (better-movefocus "l")
            ];
          }
          {
            _args = [
              "${mainMod} + mouse_down"
              (mkLuaInline ''
                hl.dsp.focus({
                  workspace = 'm-1'
                })
              '')
            ];
          }
          {
            _args = [
              "${mainMod} + mouse_up"
              (mkLuaInline ''
                hl.dsp.focus({
                  workspace = 'm+1'
                })
              '')
            ];
          }
          {
            _args = [
              "${mainMod} + Period"
              (mkLuaInline "hl.dsp.exec_cmd('uwsm app -- wofi-emoji')")
            ];
          }
          {
            _args = [
              "${mainMod} + Print"
              (mkLuaInline ''hl.dsp.exec_cmd('uwsm app -- grimblast --notify copysave screen "$HOME/Pictures/Screenshots/$(date +%Y-%m-%dT%H-%M-%S).png"')'')
            ];
          }
          {
            _args = [
              "${mainMod} + Return"
              (mkLuaInline "hl.dsp.exec_cmd('uwsm app -- ${terminal}')")
            ];
          }
          {
            _args = [
              "${mainMod} + Right"
              (better-movefocus "r")
            ];
          }
          {
            _args = [
              "${mainMod} + S"
              (mkLuaInline "hl.dsp.exec_cmd('uwsm app -- wofi --show drun --width 512px')")
            ];
          }
          {
            _args = [
              "${mainMod} + Tab"
              toggle-monitor
            ];
          }
          {
            _args = [
              "${mainMod} + Up"
              (better-movefocus "u")
            ];
          }
          {
            _args = [
              "${mainMod} + X"
              (mkLuaInline "hl.dsp.exec_cmd('uwsm app -- systemctl suspend')")
            ];
          }
          {
            _args = [
              "${subMod} + SHIFT + Tab"
              (mkLuaInline ''
                hl.dsp.window.cycle_next({
                  next = false
                })
              '')
            ];
          }
          {
            _args = [
              "${subMod} + Tab"
              (mkLuaInline "hl.dsp.window.cycle_next()")
            ];
          }
          {
            _args = [
              "Print"
              (mkLuaInline ''hl.dsp.exec_cmd('uwsm app -- grimblast --notify copysave output "$HOME/Pictures/Screenshots/$(date +%Y-%m-%dT%H-%M-%S).png"')'')
            ];
          }
          {
            _args = [
              "XF86AudioMute"
              (mkLuaInline "hl.dsp.exec_cmd('uwsm app -- pamixer -t')")
              {
                locked = true;
              }
            ];
          }
          {
            _args = [
              "XF86AudioNext"
              (mkLuaInline "hl.dsp.exec_cmd('uwsm app -- playerctl next')")
              {
                locked = true;
              }
            ];
          }
          {
            _args = [
              "XF86AudioPlay"
              (mkLuaInline "hl.dsp.exec_cmd('uwsm app -- playerctl play-pause')")
              {
                locked = true;
              }
            ];
          }
          {
            _args = [
              "XF86AudioPrev"
              (mkLuaInline "hl.dsp.exec_cmd('uwsm app -- playerctl previous')")
              {
                locked = true;
              }
            ];
          }
          {
            _args = [
              "XF86AudioLowerVolume"
              (mkLuaInline "hl.dsp.exec_cmd('uwsm app -- pamixer -d 5')")
              {
                locked = true;
                repeating = true;
              }
            ];
          }
          {
            _args = [
              "XF86AudioRaiseVolume"
              (mkLuaInline "hl.dsp.exec_cmd('uwsm app -- pamixer -i 5')")
              {
                locked = true;
                repeating = true;
              }
            ];
          }
          {
            _args = [
              "XF86MonBrightnessDown"
              (mkLuaInline "hl.dsp.exec_cmd('uwsm app -- brightnessctl set 5%-')")
              {
                locked = true;
                repeating = true;
              }
            ];
          }
          {
            _args = [
              "XF86MonBrightnessUp"
              (mkLuaInline "hl.dsp.exec_cmd('uwsm app -- brightnessctl set +5%')")
              {
                locked = true;
                repeating = true;
              }
            ];
          }
          {
            _args = [
              "${mainMod} + mouse:272"
              (mkLuaInline "hl.dsp.window.drag()")
              {
                mouse = true;
              }
            ];
          }
          {
            _args = [
              "${mainMod} + mouse:273"
              (mkLuaInline "hl.dsp.window.resize()")
              {
                mouse = true;
              }
            ];
          }
        ];
      };
  };
}
