import QtQuick

pragma Singleton

QtObject {
    id: stylix

    // Base16 Palette Tokens (Stylix / Andesite)
    readonly property color base00: "#181825" // Default Background
    readonly property color base01: "#1e1e2e" // Lighter Background / Surface
    readonly property color base02: "#313244" // Selection Background
    readonly property color base03: "#45475a" // Border / Muted
    readonly property color base04: "#a6adc8" // Dark Foreground / Secondary
    readonly property color base05: "#cdd6f4" // Default Foreground / Primary Text
    readonly property color base06: "#f5e0dc" // Light Foreground
    readonly property color base07: "#b4befe" // Extra Light
    readonly property color base08: "#f38ba8" // Red / Danger
    readonly property color base09: "#fab387" // Orange / Warning
    readonly property color base0A: "#f9e2af" // Yellow
    readonly property color base0B: "#a6e3a1" // Green / Success
    readonly property color base0C: "#89dceb" // Cyan / Ice Accent
    readonly property color base0D: "#89b4fa" // Blue / Accent
    readonly property color base0E: "#cba6f7" // Purple / Mauve
    readonly property color base0F: "#f5c2e7" // Pink / Highlight

    // Typography Tokens
    readonly property string fontSans: "Iosevka Nerd Font"
    readonly property string fontMono: "Iosevka Nerd Font"
}
