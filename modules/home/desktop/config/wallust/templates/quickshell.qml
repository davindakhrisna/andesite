import QtQuick

pragma Singleton

QtObject {
    id: stylix

    // Base16 / Wallust Palette Tokens
    readonly property color base00: "{{background}}"
    readonly property color base01: "{{color0}}"
    readonly property color base02: "{{color8}}"
    readonly property color base03: "{{color8}}"
    readonly property color base04: "{{color7}}"
    readonly property color base05: "{{foreground}}"
    readonly property color base06: "{{color15}}"
    readonly property color base07: "{{color15}}"
    readonly property color base08: "{{color1}}"
    readonly property color base09: "{{color3}}"
    readonly property color base0A: "{{color11}}"
    readonly property color base0B: "{{color2}}"
    readonly property color base0C: "{{color6}}"
    readonly property color base0D: "{{color4}}"
    readonly property color base0E: "{{color5}}"
    readonly property color base0F: "{{color13}}"

    // Typography Tokens
    readonly property string fontSans: "Iosevka Nerd Font"
    readonly property string fontMono: "Iosevka Nerd Font"
}
