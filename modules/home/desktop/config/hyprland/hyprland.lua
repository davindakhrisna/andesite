-- ==============================================================================
-- Hyprland Lua Configuration
-- Hot-reloaded via mkOutOfStoreSymlink (~/.config/hypr/hyprland.lua)
-- ==============================================================================

------------------
---- MONITORS ----
------------------

-- Using "highrr" automatically picks the highest available refresh rate (e.g., 144Hz/165Hz)
hl.monitor({
    output   = "",
    mode     = "highrr",
    position = "0x0",
    scale    = "1",
    vrr = 1
})

--------------------
---- CONFIGURATION -
--------------------

hl.config({
    general = {
        gaps_in = 12,
        gaps_out = 18,
        border_size = 3,
        layout = "dwindle",
        allow_tearing = false,
    },
    cursor = {
        -- Prevents stutter/frame pacing issues on NVIDIA hardware
        no_hardware_cursors = true,
    },
    decoration = {
        rounding = 0,
        active_opacity = 1.0,
        inactive_opacity = 0.92,
        blur = {
            enabled = true,
            size = 5,
            passes = 2,
            new_optimizations = true,
            xray = true,
        },
        shadow = {
            enabled = false,
        },
    },
    animations = {
        enabled = true,
    },
    input = {
        kb_layout = "us",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = false,
        },
    },
    dwindle = {
        preserve_split = true,
    },
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
    },
})

--------------------
---- ANIMATIONS ----
--------------------

hl.curve("snappy", {
    type = "bezier",
    points = { {0.25, 1}, {0.5, 1} }
})
hl.curve("smoothOut", {
    type = "bezier",
    points = { {0.16, 1}, {0.3, 1} }
})

hl.animation({ leaf = "windows",    enabled = true, speed = 4, bezier = "smoothOut" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "snappy" })
hl.animation({ leaf = "border",     enabled = true, speed = 4, bezier = "smoothOut" })
hl.animation({ leaf = "fade",       enabled = true, speed = 3, bezier = "snappy" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "smoothOut" })

----------------------
---- WINDOW RULES ----
----------------------

hl.window_rule({
    name = "tui-modal",
    match = {
        class = "tui-modal",
    },
    float = true,
    size = "760 460",
    center = true,
})

hl.window_rule({
    name = "screensaver",
    match = {
        class = "screensaver",
    },
    fullscreen = true,
    border_size = 0,
})

---------------------
---- LAYER RULES ----
---------------------

hl.layer_rule({
    name = "rofi-dim",
    match = {
        namespace = "rofi",
    },
    dim_around = true,
    blur = true,
})

---------------------
---- AUTOSTART ------
---------------------

hl.on("hyprland.start", function()
    hl.dsp.exec_cmd("waybar")
    hl.dsp.exec_cmd("hypridle")
    hl.dsp.exec_cmd("awww-daemon")
    hl.dsp.exec_cmd("dunst")
    hl.dsp.exec_cmd("swayosd-server")
end)

---------------------
---- KEYBINDINGS ----
---------------------

require("bindings")
