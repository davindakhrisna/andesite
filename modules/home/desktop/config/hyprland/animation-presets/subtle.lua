-- ==============================================================================
-- Hyprland Animation Preset: Subtle & Minimal
-- ==============================================================================

hl.curve("gentle", {
    type = "bezier",
    points = { {0.0, 0.0}, {0.58, 1.0} }
})

hl.animation({ leaf = "windows",          enabled = true, speed = 3, bezier = "gentle", style = "fade" })
hl.animation({ leaf = "windowsOut",       enabled = true, speed = 2, bezier = "gentle", style = "fade" })
hl.animation({ leaf = "border",           enabled = true, speed = 3, bezier = "gentle" })
hl.animation({ leaf = "fade",             enabled = true, speed = 3, bezier = "gentle" })
hl.animation({ leaf = "workspaces",       enabled = true, speed = 3, bezier = "gentle", style = "fade" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 2, bezier = "gentle", style = "fade" })
