-- ==============================================================================
-- Hyprland Animation Preset: Fast & Snappy
-- ==============================================================================

hl.curve("fast", {
    type = "bezier",
    points = { {0.2, 0.9}, {0.1, 1.0} }
})
hl.curve("linear", {
    type = "bezier",
    points = { {0.0, 0.0}, {1.0, 1.0} }
})

hl.animation({ leaf = "windows",          enabled = true, speed = 2, bezier = "fast" })
hl.animation({ leaf = "windowsOut",       enabled = true, speed = 2, bezier = "fast" })
hl.animation({ leaf = "border",           enabled = true, speed = 2, bezier = "fast" })
hl.animation({ leaf = "fade",             enabled = true, speed = 2, bezier = "linear" })
hl.animation({ leaf = "workspaces",       enabled = true, speed = 3, bezier = "fast" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 2, bezier = "fast", style = "fade" })
