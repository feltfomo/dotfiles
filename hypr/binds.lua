-- App Binds
hl.bind(Mod .. " + T", hl.dsp.exec_cmd(Terminal))
hl.bind(Mod .. " + SPACE", hl.dsp.exec_cmd(Menu))

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

-- Log Out Bind
hl.bind(Mod .. " + M",
    hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))

-- Switch workspaces with mainMod + [0-9]
if HostName == "khion" then
    local workspace = require("helpers/workspace")
    for i = 1, 10 do workspace.bind_workspace(i) end
else
    for i = 1, 10 do
        local key = tostring(i % 10)
        hl.bind(Mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
        hl.bind(Mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
    end
end

-- layout switcher submap
hl.bind(Mod .. " + L", hl.dsp.submap("layout"))
hl.define_submap("layout", function()
    hl.bind("d", function()
        hl.config({ general = { layout = "dwindle" } })
        hl.dispatch(hl.dsp.submap("reset"))
    end)
    hl.bind("m", function()
        hl.config({ general = { layout = "master" } })
        hl.dispatch(hl.dsp.submap("reset"))
    end)
    hl.bind("s", function()
        hl.config({ general = { layout = "scrolling" } })
        hl.dispatch(hl.dsp.submap("reset"))
    end)
    hl.bind("o", function()
        hl.config({ general = { layout = "monocle" } })
        hl.dispatch(hl.dsp.submap("reset"))
    end)
    hl.bind("Escape", hl.dsp.submap("reset"))
end)
