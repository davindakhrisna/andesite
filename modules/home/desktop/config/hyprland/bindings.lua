-- ==============================================================================
-- Hyprland Keybindings (Lua)
-- Hot-reloaded via mkOutOfStoreSymlink (~/.config/hypr/bindings.lua)
-- ==============================================================================

local mainMod = "SUPER"
local terminal = "kitty"
local flintDir = os.getenv("FLINT_DIR") or ((os.getenv("HOME") or "") .. "/.config/flint")
local scriptDir = flintDir .. "/modules/home/desktop/config/hyprland/scripts/"

----------------------------------------
-- Core Actions: Terminal
----------------------------------------

-- Enter terminal
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))

-- Rofi
hl.bind(mainMod .. " + Space",  hl.dsp.exec_cmd("rofi -show drun -show-icons"))             -- Application Launcher (Rofi)
hl.bind(mainMod .. " + comma",      hl.dsp.exec_cmd(scriptDir .. "clipboard.sh"))               -- Clipboard History (Cliphist + Rofi)
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd("rofimoji --action copy"))                  -- Emoji & Glyph Picker (Rofimoji)
hl.bind(mainMod .. " + Escape",    hl.dsp.exec_cmd(scriptDir .. "powermenu.sh"))            -- Power Menu (Rofi TUI Modal)
hl.bind(mainMod .. " + T",         hl.dsp.exec_cmd(scriptDir .. "wallpaper-switcher.sh"))   -- Wallpaper Switcher (Awww + Rofi Visual Grid)
hl.bind(mainMod .. " + A",         hl.dsp.exec_cmd(scriptDir .. "animation-switcher.sh"))   -- Animation Preset Switcher (Rofi)
hl.bind(mainMod .. " + slash",     hl.dsp.exec_cmd(scriptDir .. "keybindings-cheatsheet.sh")) -- Keybindings Cheatsheet (Rofi / TUI)
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("kitty --class tui-modal -e flint-pkgs")) -- Packages & Modules Explorer (Flint-Pkgs TUI Modal)

-- Scripts
hl.bind(mainMod .. " + N",         hl.dsp.exec_cmd(scriptDir .. "nightlight.sh"))           -- Night Light Toggle (Hyprsunset)
hl.bind(mainMod .. " + G",        hl.dsp.exec_cmd(scriptDir .. "gamemode.sh"))             -- Game Mode Toggle (Max FPS)

----------------------------------------
-- Screenshots (Grim + Slurp + Satty)
-- [Workflow: Region/Full -> Copy to Clipboard FIRST -> Open in Satty]
----------------------------------------

hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd(scriptDir .. "screenshot.sh region"))    -- Region / Area screenshot 
hl.bind(mainMod .. " + Print",     hl.dsp.exec_cmd(scriptDir .. "screenshot.sh full"))      -- Fullscreen screenshot

----------------------------------------
-- Window Layout & Floating
----------------------------------------

hl.bind(mainMod .. " + Q",      hl.dsp.window.close())                                      -- Close active app / window
hl.bind(mainMod .. " + W", function()                                                        -- Toggle Floating Window (Compact & Centered)
    hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
    hl.dispatch(hl.dsp.window.resize({ x = 960, y = 600, exact = true }))
    hl.dispatch(hl.dsp.window.center())
end)
hl.bind(mainMod .. " + F",             hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + SHIFT + L",             hl.dsp.layout("togglesplit"))

----------------------------------------
-- Scratchpad (Special Workspace)
----------------------------------------

hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))            -- Toggle special scratchpad workspace
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" })) -- Move active window to special scratchpad workspace

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
hl.bind(mainMod .. " + J",      hl.dsp.focus({ direction = "down" }))

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
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(scriptDir .. "osd.sh volume_up"),   { ["repeat"] = true, locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(scriptDir .. "osd.sh volume_down"), { ["repeat"] = true, locked = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd(scriptDir .. "osd.sh volume_mute"), { locked = true })

-- Audio Mic (Input)
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd(scriptDir .. "osd.sh mic_mute"),    { locked = true })

-- Brightness (Backlight)
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd(scriptDir .. "osd.sh brightness_up"),   { ["repeat"] = true, locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(scriptDir .. "osd.sh brightness_down"), { ["repeat"] = true, locked = true })

-- Media Playback Controls (Playerctl)
hl.bind("XF86AudioPlay",        hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause",       hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext",        hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPrev",        hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

----------------------------------------
-- Apps
----------------------------------------

hl.bind(mainMod .. " + SHIFT + B",  hl.dsp.exec_cmd("helium"))  
hl.bind(mainMod .. " + SHIFT + M",  hl.dsp.exec_cmd("spotify"))
hl.bind(mainMod .. " + SHIFT + N",  hl.dsp.exec_cmd("kitty -e nvim"))
hl.bind(mainMod .. " + E",  hl.dsp.exec_cmd("kitty -e yazi"))
hl.bind(mainMod .. " + SHIFT + O",  hl.dsp.exec_cmd("obsidian"))
hl.bind(mainMod .. " + SHIFT + D",  hl.dsp.exec_cmd("vesktop"))