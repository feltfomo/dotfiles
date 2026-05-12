-- App Binds
hl.bind(Mod .. " + T", hl.dsp.exec_cmd(Terminal))
hl.bind(Mod .. " + R", hl.dsp.exec_cmd(Menu))

-- Window Binds
hl.bind(Mod .. " + Q", hl.dsp.window.close())

-- Window Focus Binds
hl.bind(Mod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(Mod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(Mod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(Mod .. " + down", hl.dsp.focus({ direction = "down" }))
-- (vim bindings)
hl.bind(Mod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(Mod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(Mod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(Mod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Monitor Focus Binds
hl.bind(Mod .. " + ALT + h", hl.dsp.focus({ monitor = "DP-1" }))
hl.bind(Mod .. " + ALT + l", hl.dsp.focus({ monitor = "DP-2" }))

hl.bind(Mod .. " + M",
    hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))

-- Switch workspaces with mainMod + [0-9]
if HostName == "khion" then
    local monitor_offsets = {
        ["DP-1"] = 0,
        ["DP-2"] = 10,
    }

    local function ws_offset()
        local ws = hl.get_active_workspace()
        if ws and ws.monitor then
            return monitor_offsets[ws.monitor.name] or 0
        end
        return 0
    end

    for i = 1, 10 do
        local key = tostring(i % 10)

        hl.bind(Mod .. " + " .. key, function()
            hl.dispatch(hl.dsp.focus({ workspace = i + ws_offset() }))
        end)

        -- dont follow window to workspace
        hl.bind(Mod .. " + SHIFT + " .. key, function()
            local ws = hl.get_active_workspace()
            local current = ws and ws.id or 1
            hl.dispatch(hl.dsp.window.move({ workspace = i + ws_offset() }))
            hl.dispatch(hl.dsp.focus({ workspace = current }))
        end)

        -- follow window to workspace
        hl.bind(Mod .. " + CTRL + " .. key, function()
            local target = i + ws_offset()
            hl.dispatch(hl.dsp.window.move({ workspace = target }))
            hl.dispatch(hl.dsp.focus({ workspace = target }))
        end)
    end
end
