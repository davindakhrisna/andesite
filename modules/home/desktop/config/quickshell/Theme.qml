import QtQuick

pragma Singleton

QtObject {
    id: theme

    // Direct Stylix Reference
    readonly property var stylix: Stylix

    // Semantic Colors (aligned with Stylix & doannc2212/quickshell-config)
    readonly property color bgBase: Stylix.base00
    readonly property color bgSurface: Stylix.base01
    readonly property color bgOverlay: "#cc181825"
    readonly property color bgHover: Stylix.base02
    readonly property color bgSelected: Stylix.base02
    readonly property color bgActive: Stylix.base03
    readonly property color bgBorder: Stylix.base03

    // Text & Foreground
    readonly property color textPrimary: Stylix.base05
    readonly property color textSecondary: Stylix.base04
    readonly property color textMuted: Stylix.base03
    readonly property color textHighlight: Stylix.base06
    readonly property color textDark: Stylix.base00

    // Accents
    readonly property color accentPrimary: Stylix.base0C   // Ice Cyan
    readonly property color accentSecondary: Stylix.base0D // Blue
    readonly property color accentCyan: Stylix.base0C
    readonly property color accentGreen: Stylix.base0B     // Green
    readonly property color accentOrange: Stylix.base09    // Orange
    readonly property color accentYellow: Stylix.base0A    // Yellow
    readonly property color accentRed: Stylix.base08       // Red
    readonly property color accentPurple: Stylix.base0E    // Mauve

    // Urgency & Status
    readonly property color urgencyLow: Stylix.base04
    readonly property color urgencyNormal: Stylix.base0C
    readonly property color urgencyCritical: Stylix.base08
    readonly property color batteryGood: Stylix.base0B
    readonly property color batteryWarning: Stylix.base09
    readonly property color batteryCritical: Stylix.base08

    // Fonts
    readonly property string fontSans: Stylix.fontSans
    readonly property string fontMono: Stylix.fontMono
    readonly property string font: Stylix.fontMono

    readonly property int fontSizeSmall: 11
    readonly property int fontSizeNormal: 12
    readonly property int fontSizeMedium: 13
    readonly property int fontSizeLarge: 14

    // Dimensions & Spacing
    readonly property int barHeight: 38
    readonly property int barMargin: 6
    readonly property int pillHeight: 26
    readonly property int pillRadius: 6
    readonly property int cornerRadius: 8
    readonly property int paddingSmall: 4
    readonly property int paddingNormal: 8
    readonly property int paddingLarge: 12
    readonly property int spacing: 6

    // Animation Durations (ms)
    readonly property int animFast: 100
    readonly property int animNormal: 180
    readonly property int animSlow: 300
}
