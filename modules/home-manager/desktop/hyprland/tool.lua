local lib = require("lib")

local M = {}

function M.better_movefocus(dir)
    return function()
        local active_window = hl.get_active_window()
        if active_window ~= nil and active_window.fullscreen ~= 0 then
            local monitors = hl.get_monitors()
            local suggested_monitors = lib.map(
                lib.filter(monitors, function(m)
                    return not m.focused
                end),
                function(m)
                    return m.activeWorkspace.id
                end
            )
            if 0 < #suggested_monitors then
                hl.dispatch(hl.dsp.focus({
                    workspace = suggested_monitors[1],
                }))
            end
        else
            hl.dispatch(hl.dsp.focus({
                direction = dir,
            }))
        end
    end
end

function M.toggle_monitor()
    return function()
        local monitors = hl.get_monitors()
        local suggested_monitors = lib.map(
            lib.filter(monitors, function(m)
                return not m.focused
            end),
            function(m)
                return m.activeWorkspace.id
            end
        )
        if 0 < #suggested_monitors then
            hl.dispatch(hl.dsp.focus({
                workspace = suggested_monitors[1],
            }))
        end
    end
end

function M.ws_move(id)
    return function()
        local monitor = hl.get_active_workspace().monitor.id
        hl.dispatch(hl.dsp.window.move({
            workspace = monitor * 10 + id,
        }))
    end
end

function M.ws_switch(id)
    return function()
        local monitor = hl.get_active_workspace().monitor.id
        hl.dispatch(hl.dsp.focus({
            workspace = monitor * 10 + id,
        }))
    end
end

return M
