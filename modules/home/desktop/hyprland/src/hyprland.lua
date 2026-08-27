-- Hyprland Lua Configuration
-- Live configuration loaded directly from repository

-------------------
---- AUTOSTART ----
-------------------

local scriptDir = (os.getenv("HOME") or "") .. "/.config/flint/modules/home/desktop/hyprland/scripts/"

hl.on("hyprland.start", function ()
    hl.exec_cmd(scriptDir .. "auto-monitor.sh")
    hl.exec_cmd("quickshell")
end)

------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "1",
})

---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "kitty"
local fileManager = "thunar"
local menu        = "rofi -show drun"

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
    },
})

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout    = "us",
        follow_mouse = 1,
        sensitivity  = 0,
        touchpad = {
            natural_scroll = false,
        },
    },
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

-- Applications & Windows
hl.bind(mainMod .. " + RETURN",    hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q",         hl.dsp.window.close())
hl.bind(mainMod .. " + M",         hl.dsp.exec_cmd("hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E",         hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V",         hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R",         hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P",         hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J",         hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + Escape",    hl.dsp.exec_cmd("wlogout -b 5"))

-- Screenshots & Screen Recording (ss-toolkit)
hl.bind("Print",                   hl.dsp.exec_cmd(scriptDir .. "screenshot.sh area"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(scriptDir .. "screenshot.sh area"))
hl.bind("SHIFT + Print",           hl.dsp.exec_cmd(scriptDir .. "screenshot.sh full"))
hl.bind("CTRL + Print",            hl.dsp.exec_cmd(scriptDir .. "screenshot.sh clip"))
hl.bind(mainMod .. " + Print",     hl.dsp.exec_cmd(scriptDir .. "screenshot.sh swappy"))
hl.bind(mainMod .. " + ALT + R",   hl.dsp.exec_cmd(scriptDir .. "screenrecord.sh"))

-- Focus movement
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Workspaces
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Mouse window controls
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
