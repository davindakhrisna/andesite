-- ==============================================================================
-- Hyprland Keybindings (Lua)
-- Hot-reloaded via mkOutOfStoreSymlink (~/.config/hypr/bindings.lua)
-- ==============================================================================

local mainMod = "SUPER"
local terminal = "kitty"

----------------------------------------
-- Core Actions: Terminal, Close, Exit
----------------------------------------

-- Enter terminal
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + T",      hl.dsp.exec_cmd(terminal))

-- Close active app / window
hl.bind(mainMod .. " + Q",      hl.dsp.window.close())
hl.bind(mainMod .. " + C",      hl.dsp.window.close())

-- Exit Hyprland session / Power Menu / Wallpaper Switcher
local scriptDir = (os.getenv("HOME") or "") .. "/.config/flint/modules/home/desktop/config/hyprland/scripts/"
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("hyprctl dispatch exit"))
hl.bind(mainMod .. " + Escape",    hl.dsp.exec_cmd(scriptDir .. "powermenu.sh"))
hl.bind(mainMod .. " + W",         hl.dsp.exec_cmd(scriptDir .. "wallpaper-switcher.sh"))

-- Window layout & floating
hl.bind(mainMod .. " + V",      hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F",      hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + P",      hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J",      hl.dsp.layout("togglesplit"))

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
