local hostname = io.popen("hostname"):read("*l")
if hostname == "lumi" then
    hl.monitor({
        output = "eDP-1",
        mode = "1920x1080@60",
        position = "0x0",
        scale = "1",
    })
elseif hostname == "khion" then
    hl.monitor({
        output = "DP-1",
        mode = "2560x1440@180",
        position = "0x0",
        scale = "1",
    })
    hl.monitor({
        output = "DP-2",
        mode = "2560x1440@180",
        position = "2560x0",
        scale = "1",
    })
end

hl.on("monitor.added", function(m)
    if hostname == "khion" and m.name == "DP-2" then
        hl.exec_cmd("hyprctl keyword monitor DP-2,2560x1440@180,2560x0,1")
    end
end)
