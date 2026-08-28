-- ==============================================================================
-- Hyprland Animation Preset: Spring & Bouncy
-- ==============================================================================

hl.curve("bounce", {
    type = "bezier",
    points = { {0.34, 1.35}, {0.64, 1.0} }
})
hl.curve("easeOut", {
    type = "bezier",
    points = { {0.16, 1.0}, {0.3, 1.0} }
})

hl.animation({ leaf = "windows",          enabled = true, speed = 5, bezier = "bounce", style = "popin 80%" })
hl.animation({ leaf = "windowsOut",       enabled = true, speed = 4, bezier = "easeOut", style = "popin 85%" })
hl.animation({ leaf = "border",           enabled = true, speed = 5, bezier = "bounce" })
hl.animation({ leaf = "fade",             enabled = true, speed = 4, bezier = "easeOut" })
hl.animation({ leaf = "workspaces",       enabled = true, speed = 5, bezier = "bounce", style = "slidefade 20%" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 4, bezier = "bounce", style = "fade" })
