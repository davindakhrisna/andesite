import QtQuick

QtObject {
  readonly property color bgBase: Theme.bgBase
  readonly property color bgSurface: Theme.bgSurface
  readonly property color bgOverlay: Theme.bgOverlay
  readonly property color bgHover: Theme.bgHover
  readonly property color bgSelected: Theme.bgSelected
  readonly property color bgBorder: Theme.bgBorder

  readonly property color textPrimary: Theme.textPrimary
  readonly property color textSecondary: Theme.textSecondary
  readonly property color textMuted: Theme.textMuted

  readonly property color accentPrimary: Theme.accentPrimary
  readonly property color accentCyan: Theme.accentCyan
  readonly property color accentGreen: Theme.accentGreen
  readonly property color accentOrange: Theme.accentOrange
  readonly property color accentRed: Theme.accentRed
  readonly property color accentPurple: Theme.accentPurple

  readonly property color urgencyLow: Theme.urgencyLow
  readonly property color urgencyNormal: Theme.urgencyNormal
  readonly property color urgencyCritical: Theme.urgencyCritical
  readonly property color batteryGood: Theme.batteryGood
  readonly property color batteryWarning: Theme.batteryWarning
  readonly property color batteryCritical: Theme.batteryCritical
}