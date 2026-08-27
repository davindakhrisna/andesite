-- Hyprland Lua Configuration - Andesite TUI Theme
-- Live configuration loaded directly from repository

-------------------
---- AUTOSTART ----
-------------------

local scriptDir = (os.getenv("HOME") or "") .. "/.config/flint/modules/home/desktop/config/hyprland/scripts/"

hl.on("hyprland.start", function ()
    hl.exec_cmd(scriptDir .. "autostart.sh")
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

--------------------
---- CONFIGURATION -
--------------------

hl.config({
    general = {
        gaps_in = 4,
        gaps_out = 8,
        border_size = 2,
        layout = "dwindle",
    },
    decoration = {
        rounding = 0,
        active_opacity = 0.98,
        inactive_opacity = 0.92,
        blur = {
            enabled = true,
            size = 6,
            passes = 2,
        },
    },
    input = {
        kb_layout = "us",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = false,
        },
    },
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
    },
    windowrulev2 = {
        "float, class:^(tui-modal)$",
        "size 960 620, class:^(tui-modal)$",
        "center, class:^(tui-modal)$",
        "float, class:^(tui-modal-large)$",
        "size 1200 800, class:^(tui-modal-large)$",
        "center, class:^(tui-modal-large)$",
        "float, class:^(tui-cheatsheet)$",
        "size 900 650, class:^(tui-cheatsheet)$",
        "center, class:^(tui-cheatsheet)$",
        "float, class:^(satty)$",
        "float, class:^(swappy)$",
        "float, class:^(org.gnome.FileRoller)$",
    },
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

-- Core Applications & Shell
hl.bind(mainMod .. " + RETURN",      hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Space",       hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + R",           hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + Q",           hl.dsp.window.close())
hl.bind(mainMod .. " + M",           hl.dsp.exec_cmd("hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + V",           hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P",           hl.dsp.window.pseudo())
hl.bind(mainMod .. " + SHIFT + P",   hl.dsp.exec_cmd("rofi-rbw"))
hl.bind(mainMod .. " + J",           hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + SHIFT + R",   hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + Escape",      hl.dsp.exec_cmd("wlogout -b 5"))

-- Dedicated TUI Scratchpads
hl.bind(mainMod .. " + E",           hl.dsp.exec_cmd("kitty --class tui-modal -e yazi"))
hl.bind(mainMod .. " + SHIFT + E",   hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + A",           hl.dsp.exec_cmd("kitty --class tui-modal -e wiremix"))
hl.bind(mainMod .. " + B",           hl.dsp.exec_cmd("kitty --class tui-modal -e bluetui"))
hl.bind(mainMod .. " + N",           hl.dsp.exec_cmd("kitty --class tui-modal -e gazelle-tui"))
hl.bind(mainMod .. " + D",           hl.dsp.exec_cmd("kitty --class tui-modal -e hyprmon"))
hl.bind(mainMod .. " + T",           hl.dsp.exec_cmd("kitty --class tui-modal-large -e nvim ~/Notes/index.md --cmd 'cd ~/Notes'"))
hl.bind(mainMod .. " + slash",       hl.dsp.exec_cmd(scriptDir .. "cheatsheet.sh"))
hl.bind(mainMod .. " + W",           hl.dsp.exec_cmd(scriptDir .. "wall-switch.sh"))

-- Tools & Utilities
hl.bind(mainMod .. " + C",           hl.dsp.exec_cmd(scriptDir .. "clipboard.sh"))
hl.bind(mainMod .. " + period",      hl.dsp.exec_cmd("rofimoji"))
hl.bind(mainMod .. " + F1",          hl.dsp.exec_cmd(scriptDir .. "gamemode.sh"))
hl.bind(mainMod .. " + ALT + N",     hl.dsp.exec_cmd(scriptDir .. "nightlight.sh"))

-- Screenshots & Screen Recording (ss-toolkit)
hl.bind("Print",                     hl.dsp.exec_cmd(scriptDir .. "screenshot.sh area"))
hl.bind(mainMod .. " + SHIFT + S",   hl.dsp.exec_cmd(scriptDir .. "screenshot.sh area"))
hl.bind("SHIFT + Print",             hl.dsp.exec_cmd(scriptDir .. "screenshot.sh full"))
hl.bind("CTRL + Print",              hl.dsp.exec_cmd(scriptDir .. "screenshot.sh clip"))
hl.bind(mainMod .. " + Print",       hl.dsp.exec_cmd(scriptDir .. "screenshot.sh swappy"))
hl.bind(mainMod .. " + ALT + R",     hl.dsp.exec_cmd(scriptDir .. "screenrecord.sh"))

-- Hardware & Media Keys (Volume, Brightness, Playback)
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set +5%"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"))
hl.bind("XF86AudioPlay",         hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext",         hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev",         hl.dsp.exec_cmd("playerctl previous"))

-- Focus movement
hl.bind(mainMod .. " + left",        hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right",       hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",          hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",        hl.dsp.focus({ direction = "down" }))

-- Workspaces
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Mouse window controls
hl.bind(mainMod .. " + mouse:272",   hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273",   hl.dsp.window.resize(), { mouse = true })
