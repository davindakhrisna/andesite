import QtQuick

pragma Singleton

QtObject {
    id: theme

    // Colors - Andesite Dark Glass Palette
    readonly property color bg: "#16161ecc"
    readonly property color bgSolid: "#16161e"
    readonly property color pillBg: "#1f2335aa"
    readonly property color pillBgHover: "#292e42dd"
    readonly property color pillBgActive: "#3b4261"
    
    readonly property color border: "#ffffff14"
    readonly property color borderHover: "#ffffff2e"
    readonly property color borderActive: "#eb6f9288"

    // Accents (Rose Pine & Andesite inspired)
    readonly property color accent: "#eb6f92"       // Rose
    readonly property color accentSecondary: "#9ccfd8" // Foam/Cyan
    readonly property color accentSuccess: "#31748f"   // Pine
    readonly property color accentWarning: "#f6c177"   // Gold
    readonly property color accentMuted: "#ebbcba"     // Iris

    // Typography Colors
    readonly property color text: "#e0def4"
    readonly property color textMuted: "#908caa"
    readonly property color textSubtle: "#6e6a86"
    readonly property color textDark: "#191724"

    // Fonts
    readonly property string fontSans: "Rubik"
    readonly property string fontMono: "Maple Mono NF"
    readonly property int fontSizeSmall: 11
    readonly property int fontSizeNormal: 12
    readonly property int fontSizeMedium: 13
    readonly property int fontSizeLarge: 14

    // Layout Tokens
    readonly property int barHeight: 40
    readonly property int barMargin: 8
    readonly property int pillHeight: 28
    readonly property int pillRadius: 10
    readonly property int cornerRadius: 14
    readonly property int paddingSmall: 4
    readonly property int paddingNormal: 8
    readonly property int paddingLarge: 12
    readonly property int spacing: 6

    // Animation Timings
    readonly property int animFast: 120
    readonly property int animNormal: 200
    readonly property int animSlow: 350
}
