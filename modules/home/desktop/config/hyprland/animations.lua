-- ==============================================================================
-- Hyprland Animations Configuration (Lua)
-- Hot-reloaded via mkOutOfStoreSymlink (~/.config/hypr/animations.lua)
-- ==============================================================================

------------------
---- CURVES ------
------------------

hl.curve("snappy", {
    type = "bezier",
    points = { {0.25, 1}, {0.5, 1} }
})

hl.curve("smoothOut", {
    type = "bezier",
    points = { {0.16, 1}, {0.3, 1} }
})

----------------------
---- ANIMATIONS ------
----------------------

-- Windows
hl.animation({ leaf = "windows",          enabled = true, speed = 4, bezier = "smoothOut" })
hl.animation({ leaf = "windowsOut",       enabled = true, speed = 3, bezier = "snappy" })

-- Borders
hl.animation({ leaf = "border",           enabled = true, speed = 4, bezier = "smoothOut" })

-- Fade transitions
hl.animation({ leaf = "fade",             enabled = true, speed = 3, bezier = "snappy" })

-- Normal Workspaces
hl.animation({ leaf = "workspaces",       enabled = true, speed = 4, bezier = "smoothOut" })

-- Special Workspace (Scratchpad: Clean Fade-In / Fade-Out)
hl.animation({
    leaf = "specialWorkspace",
    enabled = true,
    speed = 3,
    bezier = "smoothOut",
    style = "fade"
})
