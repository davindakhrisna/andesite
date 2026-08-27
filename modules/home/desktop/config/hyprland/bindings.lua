-- ==============================================================================
-- Hyprland Keybindings (Lua)
-- Hot-reloaded via mkOutOfStoreSymlink (~/.config/hypr/bindings.lua)
-- ==============================================================================

local mainMod = "SUPER"
local terminal = "kitty"
local scriptDir = (os.getenv("HOME") or "") .. "/.config/flint/modules/home/desktop/config/hyprland/scripts/"

----------------------------------------
-- Core Actions: Terminal, Close, Exit
----------------------------------------

-- Enter terminal
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + T",      hl.dsp.exec_cmd(terminal))

-- Close active app / window
hl.bind(mainMod .. " + Q",      hl.dsp.window.close())
hl.bind(mainMod .. " + C",      hl.dsp.window.close())

-- Application Launcher (Rofi)
hl.bind(mainMod .. " + Space",  hl.dsp.exec_cmd("rofi -show drun -show-icons"))
hl.bind(mainMod .. " + D",      hl.dsp.exec_cmd("rofi -show drun -show-icons"))

-- Clipboard History (Cliphist + Rofi)
hl.bind(mainMod .. " + V",      hl.dsp.exec_cmd(scriptDir .. "clipboard.sh"))

-- Emoji & Glyph Picker (Rofimoji)
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd("rofimoji --action copy"))

-- Power Menu (Rofi TUI Modal)
hl.bind(mainMod .. " + Escape",    hl.dsp.exec_cmd(scriptDir .. "powermenu.sh"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("hyprctl dispatch exit"))

-- Wallpaper Switcher (Awww + Rofi Visual Grid)
hl.bind(mainMod .. " + W",         hl.dsp.exec_cmd(scriptDir .. "wallpaper-switcher.sh"))

-- Night Light Toggle (Hyprsunset)
hl.bind(mainMod .. " + N",         hl.dsp.exec_cmd(scriptDir .. "nightlight.sh"))

-- Game Mode Toggle (Max FPS)
hl.bind(mainMod .. " + F1",        hl.dsp.exec_cmd(scriptDir .. "gamemode.sh"))

----------------------------------------
-- Screenshots (Grim + Slurp + Satty)
-- [Workflow: Region/Full -> Copy to Clipboard FIRST -> Open in Satty]
----------------------------------------

-- Region / Area screenshot
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(scriptDir .. "screenshot.sh region"))
hl.bind("Print",                   hl.dsp.exec_cmd(scriptDir .. "screenshot.sh region"))

-- Fullscreen screenshot
hl.bind(mainMod .. " + Print",     hl.dsp.exec_cmd(scriptDir .. "screenshot.sh full"))

-- Active Window screenshot
hl.bind("ALT + Print",             hl.dsp.exec_cmd(scriptDir .. "screenshot.sh window"))

----------------------------------------
-- Window Layout & Floating
----------------------------------------

hl.bind(mainMod .. " + SHIFT + Space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F",             hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + P",             hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J",             hl.dsp.layout("togglesplit"))

----------------------------------------
-- Scratchpad (Special Workspace)
----------------------------------------

-- Toggle special scratchpad workspace
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
-- Move active window to special scratchpad workspace
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.window.move({ workspace = "special:magic" }))

----------------------------------------
-- Focus Movement
----------------------------------------

-- Arrow keys
hl.bind(mainMod .. " + left",   hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right",  hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",     hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",   hl.dsp.focus({ direction = "down" }))

-- Vim keys (H, J, K, L)
hl.bind(mainMod .. " + H",      hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L",      hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K",      hl.dsp.focus({ direction = "up" }))

----------------------------------------
-- Workspace Navigation (1 - 10)
----------------------------------------

for i = 1, 10 do
    local key = tostring(i % 10)
    -- Switch workspace
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    -- Move active window to workspace
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

----------------------------------------
-- Mouse Window Controls
----------------------------------------

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

----------------------------------------
-- Media & Hardware Controls (SwayOSD + Playerctl)
----------------------------------------

-- Audio Volume (Output)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume raise"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume lower"), { locked = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), { locked = true })

-- Audio Mic (Input)
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"), { locked = true })

-- Brightness (Backlight)
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("swayosd-client --brightness raise"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("swayosd-client --brightness lower"), { locked = true })

-- Media Playback Controls (Playerctl)
hl.bind("XF86AudioPlay",        hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause",       hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext",        hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPrev",        hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
