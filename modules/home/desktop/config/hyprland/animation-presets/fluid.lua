-- ==============================================================================
-- Hyprland Animation Preset: Fluid & Smooth
-- ==============================================================================

hl.curve("smoothOut", {
    type = "bezier",
    points = { {0.16, 1}, {0.3, 1} }
})
hl.curve("snappy", {
    type = "bezier",
    points = { {0.25, 1}, {0.5, 1} }
})

hl.animation({ leaf = "windows",          enabled = true, speed = 4, bezier = "smoothOut" })
hl.animation({ leaf = "windowsOut",       enabled = true, speed = 3, bezier = "snappy" })
hl.animation({ leaf = "border",           enabled = true, speed = 4, bezier = "smoothOut" })
hl.animation({ leaf = "fade",             enabled = true, speed = 3, bezier = "snappy" })
hl.animation({ leaf = "workspaces",       enabled = true, speed = 4, bezier = "smoothOut" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3, bezier = "smoothOut", style = "fade" })
