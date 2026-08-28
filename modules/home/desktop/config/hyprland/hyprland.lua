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
---- ENV VARIABLES -
--------------------

hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("HYPRCURSOR_SIZE", "24")

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
        col = {
            active_border = {
                colors = { "rgb(89b4fa)", "rgb(94e2d5)" },
                angle = 45,
            },
            inactive_border = "rgb(313244)",
        },
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

----------------------
---- WINDOW RULES ----
----------------------

-- TUI Modal Popups
hl.window_rule({
    name = "tui-modal",
    match = {
        class = "tui-modal",
    },
    float = true,
    size = "760 460",
    center = true,
})

-- Fullscreen Screensaver (Cmatrix)
hl.window_rule({
    name = "screensaver",
    match = {
        class = "screensaver",
    },
    fullscreen = true,
    border_size = 0,
})

-- Satty Screenshot Editor
hl.window_rule({
    name = "satty-editor",
    match = {
        class = "com.gabm.satty",
    },
    float = true,
    center = true,
})

-- Picture-in-Picture (Floating in Bottom-Right Corner)
hl.window_rule({
    name = "pip-floating",
    match = {
        title = ".*[Pp]icture.*[Ii]n.*[Pp]icture.*",
    },
    float = true,
    pin = true,
    size = "640 360",
    move = "100%-w-24 100%-h-24",
    keep_aspect_ratio = true,
    no_initial_focus = true,
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
    -- Core daemons
    hl.dsp.exec_cmd("waybar")
    hl.dsp.exec_cmd("hypridle")
    hl.dsp.exec_cmd("awww-daemon")
    hl.dsp.exec_cmd("dunst")
    hl.dsp.exec_cmd("swayosd-server")

    -- Wipe clipboard history on fresh boot/session for privacy
    hl.dsp.exec_cmd("cliphist wipe")

    -- Clipboard history watcher
    hl.dsp.exec_cmd("wl-paste --watch cliphist store")
    hl.dsp.exec_cmd("wl-paste --type image --watch cliphist store")

    -- Polkit authentication agent
    hl.dsp.exec_cmd("/run/current-system/sw/libexec/polkit-gnome-authentication-agent-1")

    -- System Event Notifier (Network, Bluetooth, Battery)
    hl.dsp.exec_cmd("system-notifier.sh")

    -- Auto Monitor Detection & Layout Confirmation
    hl.dsp.exec_cmd("auto-monitor.sh")

    -- Set default cursor theme
    hl.dsp.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 24")
end)

---------------------
---- MODULES --------
---------------------

require("animations")
require("bindings")

-- Dynamic Wallust Active/Inactive Border Colors
pcall(dofile, os.getenv("HOME") .. "/.cache/wallust/colors.lua")

-- Force Cursor Theme on Reload
hl.dsp.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 24")
