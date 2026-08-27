import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import Quickshell.Io
import Quickshell.Services.Mpris
import Quickshell.Services.Pipewire
import Quickshell.Wayland
import ".."

Scope {
  id: root
  property var theme: Theme
  property string font: Theme.font
  property bool barVisible: true

  // MPRIS active player
  property var activePlayer: {
    const players = Mpris.players.values;
    if (!players || players.length === 0) return null;
    for (const p of players) {
      if (p.playbackState === MprisPlaybackState.Playing) return p;
    }
    return players[0];
  }

  IpcHandler {
    target: "bar"
    function toggle(): void { root.barVisible = !root.barVisible; }
  }

  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink]
  }

  // Brightness state
  property real brightnessValue: 0
  property real brightnessMax: 1

  FileView {
    id: brightnessFile
    path: ""
    watchChanges: true
    onFileChanged: brightnessReadProc.running = true
  }

  Process {
    id: brightnessReadProc
    command: ["brightnessctl", "get"]
    running: false
    stdout: StdioCollector {
      onStreamFinished: {
        const val = parseInt(text.trim());
        if (!isNaN(val) && root.brightnessMax > 0) {
          root.brightnessValue = val / root.brightnessMax;
        }
      }
    }
  }

  Process {
    id: brightnessSetProc
    command: []
    running: false
  }

  Process {
    id: backlightDiscovery
    command: ["sh", "-c", "p=$(ls -d /sys/class/backlight/*/brightness 2>/dev/null | head -1); [ -n \"$p\" ] && echo \"$p\" && cat \"${p%brightness}max_brightness\""]
    running: true
    stdout: StdioCollector {
      onStreamFinished: {
        const lines = text.trim().split("\n");
        if (lines.length >= 2) {
          const max = parseInt(lines[1]);
          if (!isNaN(max) && max > 0) root.brightnessMax = max;
          brightnessFile.path = lines[0];
          brightnessReadProc.running = true;
        }
      }
    }
  }

  // Generic Command Runner (for TUI modals & system commands)
  Process {
    id: cmdRunner
    command: []
    running: false
  }

  function launchCommand(cmd) {
    cmdRunner.command = ["sh", "-c", cmd];
    cmdRunner.running = true;
  }

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: barWindow
      required property var modelData
      screen: modelData

      visible: root.barVisible
      color: "transparent"

      WlrLayershell.layer: WlrLayer.Top
      WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
      WlrLayershell.namespace: "quickshell-bar"
      exclusionMode: ExclusionMode.Auto

      anchors {
        top: true
        left: true
        right: true
      }

      implicitHeight: root.theme.barHeight + root.theme.barMargin * 2

      Rectangle {
        id: barBackground
        anchors {
          fill: parent
          topMargin: root.theme.barMargin
          bottomMargin: root.theme.barMargin
          leftMargin: root.theme.barMargin + 4
          rightMargin: root.theme.barMargin + 4
        }

        radius: root.theme.cornerRadius
        color: root.theme.bgBase
        border.color: root.theme.bgBorder
        border.width: 1

        // Bar Content Layout
        RowLayout {
          anchors.fill: parent
          anchors.leftMargin: 8
          anchors.rightMargin: 8
          spacing: root.theme.spacing

          // ==================== LEFT SECTION ====================
          Row {
            Layout.alignment: Qt.AlignLeft
            spacing: 6

            // Workspaces
            Rectangle {
              height: root.theme.pillHeight
              radius: root.theme.pillRadius
              color: root.theme.bgSurface
              border.color: root.theme.bgBorder
              border.width: 1
              implicitWidth: wsRow.implicitWidth + 8

              Row {
                id: wsRow
                anchors.centerIn: parent
                spacing: 4

                Repeater {
                  model: 10

                  Rectangle {
                    required property int index
                    readonly property int wsId: index + 1
                    readonly property var hyprWs: Hyprland.workspaces.values.find(w => w.id === wsId)
                    readonly property bool isActive: Hyprland.focusedMonitor?.activeWorkspace?.id === wsId
                    readonly property bool hasWindows: (hyprWs?.toplevels?.values?.length ?? 0) > 0 || (hyprWs?.windows ?? 0) > 0

                    width: isActive ? 24 : (hasWindows ? 16 : 10)
                    height: 14
                    radius: 7
                    color: isActive
                      ? root.theme.accentPrimary
                      : (hasWindows ? root.theme.bgSelected : root.theme.bgBorder)

                    Behavior on width { NumberAnimation { duration: root.theme.animNormal; easing.type: Easing.OutCubic } }
                    Behavior on color { ColorAnimation { duration: root.theme.animFast } }

                    MouseArea {
                      anchors.fill: parent
                      cursorShape: Qt.PointingHandCursor
                      onClicked: Hyprland.dispatch("workspace " + wsId)
                    }

                    Text {
                      anchors.centerIn: parent
                      visible: isActive
                      text: wsId
                      color: root.theme.textDark
                      font.pixelSize: 10
                      font.bold: true
                      font.family: root.font
                    }
                  }
                }
              }
            }

            // Active Window Title
            Rectangle {
              height: root.theme.pillHeight
              radius: root.theme.pillRadius
              color: root.theme.bgSurface
              border.color: root.theme.bgBorder
              border.width: 1
              visible: Hyprland.activeToplevel?.title?.length > 0
              width: Math.min(activeTitleText.implicitWidth + 20, 240)
              clip: true

              Row {
                anchors.fill: parent
                anchors.leftMargin: 8
                anchors.rightMargin: 8
                spacing: 6

                Text {
                  anchors.verticalCenter: parent.verticalCenter
                  text: "󰣆"
                  color: root.theme.accentPrimary
                  font.pixelSize: 13
                  font.family: root.font
                }

                Text {
                  id: activeTitleText
                  anchors.verticalCenter: parent.verticalCenter
                  text: Hyprland.activeToplevel?.title ?? ""
                  color: root.theme.textPrimary
                  font.pixelSize: root.theme.fontSizeSmall
                  font.family: root.font
                  elide: Text.ElideRight
                  width: parent.width - 24
                }
              }
            }
          }

          // ==================== CENTER SECTION ====================
          Row {
            Layout.alignment: Qt.AlignHCenter
            spacing: 6

            // Time & Date
            Rectangle {
              height: root.theme.pillHeight
              radius: root.theme.pillRadius
              color: root.theme.bgSurface
              border.color: root.theme.bgBorder
              border.width: 1
              implicitWidth: timeContent.implicitWidth + 16

              Row {
                id: timeContent
                anchors.centerIn: parent
                spacing: 8

                Text {
                  anchors.verticalCenter: parent.verticalCenter
                  text: "󰥔"
                  color: root.theme.accentPrimary
                  font.pixelSize: 13
                  font.family: root.font
                }

                Text {
                  anchors.verticalCenter: parent.verticalCenter
                  text: Time.timeString
                  color: root.theme.textPrimary
                  font.bold: true
                  font.pixelSize: root.theme.fontSizeNormal
                  font.family: root.font
                }

                Text {
                  anchors.verticalCenter: parent.verticalCenter
                  text: "•"
                  color: root.theme.textMuted
                  font.pixelSize: 10
                }

                Text {
                  anchors.verticalCenter: parent.verticalCenter
                  text: Time.dateString
                  color: root.theme.textSecondary
                  font.pixelSize: root.theme.fontSizeSmall
                  font.family: root.font
                }
              }
            }

            // Media Player Widget
            Rectangle {
              height: root.theme.pillHeight
              radius: root.theme.pillRadius
              color: root.theme.bgSurface
              border.color: root.theme.bgBorder
              border.width: 1
              visible: root.activePlayer != null
              implicitWidth: mediaContent.implicitWidth + 16
              clip: true

              Row {
                id: mediaContent
                anchors.centerIn: parent
                spacing: 6

                Text {
                  anchors.verticalCenter: parent.verticalCenter
                  text: root.activePlayer?.playbackState === MprisPlaybackState.Playing ? "󰐊" : "󰏤"
                  color: root.theme.accentGreen
                  font.pixelSize: 13
                  font.family: root.font
                }

                Text {
                  anchors.verticalCenter: parent.verticalCenter
                  text: {
                    const title = root.activePlayer?.trackTitle || "No Track";
                    const artist = root.activePlayer?.trackArtist || "";
                    return artist ? (title + " - " + artist) : title;
                  }
                  color: root.theme.textPrimary
                  font.pixelSize: root.theme.fontSizeSmall
                  font.family: root.font
                  elide: Text.ElideRight
                  maximumLineCount: 1
                }
              }

              MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: root.activePlayer?.togglePlaying()
              }
            }
          }

          // ==================== RIGHT SECTION ====================
          Row {
            Layout.alignment: Qt.AlignRight
            spacing: 6

            // System Info: CPU / RAM / Temperature
            Rectangle {
              height: root.theme.pillHeight
              radius: root.theme.pillRadius
              color: root.theme.bgSurface
              border.color: root.theme.bgBorder
              border.width: 1
              implicitWidth: sysStatsRow.implicitWidth + 16

              Row {
                id: sysStatsRow
                anchors.centerIn: parent
                spacing: 8

                // CPU
                Row {
                  spacing: 4
                  Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "󰻠"
                    color: root.theme.accentOrange
                    font.pixelSize: 13
                    font.family: root.font
                  }
                  Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: SystemInfo.cpuUsage
                    color: root.theme.textPrimary
                    font.pixelSize: root.theme.fontSizeSmall
                    font.family: root.font
                  }
                }

                // RAM
                Row {
                  spacing: 4
                  Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "󰍛"
                    color: root.theme.accentPurple
                    font.pixelSize: 13
                    font.family: root.font
                  }
                  Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: SystemInfo.memoryUsage
                    color: root.theme.textPrimary
                    font.pixelSize: root.theme.fontSizeSmall
                    font.family: root.font
                  }
                }

                // Temp
                Row {
                  spacing: 4
                  Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "󰔏"
                    color: root.theme.accentRed
                    font.pixelSize: 13
                    font.family: root.font
                  }
                  Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: SystemInfo.temperature
                    color: root.theme.textPrimary
                    font.pixelSize: root.theme.fontSizeSmall
                    font.family: root.font
                  }
                }
              }
            }

            // Network Widget (Click launches gazelle-tui)
            Rectangle {
              height: root.theme.pillHeight
              radius: root.theme.pillRadius
              color: root.theme.bgSurface
              border.color: root.theme.bgBorder
              border.width: 1
              implicitWidth: netRow.implicitWidth + 16

              Row {
                id: netRow
                anchors.centerIn: parent
                spacing: 6

                Text {
                  anchors.verticalCenter: parent.verticalCenter
                  text: {
                    if (SystemInfo.networkType === "ethernet") return "󰈀";
                    if (SystemInfo.networkType === "wifi") return "󰖩";
                    return "󰖪";
                  }
                  color: SystemInfo.networkType === "disconnected" ? root.theme.textMuted : root.theme.accentCyan
                  font.pixelSize: 13
                  font.family: root.font
                }

                Text {
                  anchors.verticalCenter: parent.verticalCenter
                  text: SystemInfo.networkInfo
                  color: root.theme.textPrimary
                  font.pixelSize: root.theme.fontSizeSmall
                  font.family: root.font
                }
              }

              MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: root.launchCommand("kitty --class tui-modal -e gazelle")
              }
            }

            // Volume Widget (Click launches wiremix, scroll adjusts volume)
            Rectangle {
              height: root.theme.pillHeight
              radius: root.theme.pillRadius
              color: root.theme.bgSurface
              border.color: root.theme.bgBorder
              border.width: 1
              implicitWidth: volRow.implicitWidth + 16

              readonly property real vol: Pipewire.defaultAudioSink?.audio?.volume ?? 0
              readonly property bool muted: Pipewire.defaultAudioSink?.audio?.muted ?? false

              Row {
                id: volRow
                anchors.centerIn: parent
                spacing: 6

                Text {
                  anchors.verticalCenter: parent.verticalCenter
                  text: {
                    if (parent.parent.muted || parent.parent.vol <= 0) return "󰖁";
                    if (parent.parent.vol < 0.33) return "󰕿";
                    if (parent.parent.vol < 0.66) return "󰖀";
                    return "󰕾";
                  }
                  color: parent.parent.muted ? root.theme.textMuted : root.theme.accentPrimary
                  font.pixelSize: 13
                  font.family: root.font
                }

                Text {
                  anchors.verticalCenter: parent.verticalCenter
                  text: parent.parent.muted ? "Muted" : Math.round(parent.parent.vol * 100) + "%"
                  color: root.theme.textPrimary
                  font.pixelSize: root.theme.fontSizeSmall
                  font.family: root.font
                }
              }

              MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: root.launchCommand("kitty --class tui-modal -e wiremix")
                onWheel: (wheel) => {
                  if (Pipewire.defaultAudioSink?.audio) {
                    const step = 0.05;
                    const cur = Pipewire.defaultAudioSink.audio.volume;
                    const next = wheel.angleDelta.y > 0 ? Math.min(1.0, cur + step) : Math.max(0.0, cur - step);
                    Pipewire.defaultAudioSink.audio.volume = next;
                  }
                }
              }
            }

            // Brightness Widget (Scroll adjusts brightness)
            Rectangle {
              height: root.theme.pillHeight
              radius: root.theme.pillRadius
              color: root.theme.bgSurface
              border.color: root.theme.bgBorder
              border.width: 1
              visible: root.brightnessMax > 0
              implicitWidth: brightRow.implicitWidth + 16

              Row {
                id: brightRow
                anchors.centerIn: parent
                spacing: 6

                Text {
                  anchors.verticalCenter: parent.verticalCenter
                  text: "󰃠"
                  color: root.theme.accentYellow
                  font.pixelSize: 13
                  font.family: root.font
                }

                Text {
                  anchors.verticalCenter: parent.verticalCenter
                  text: Math.round(root.brightnessValue * 100) + "%"
                  color: root.theme.textPrimary
                  font.pixelSize: root.theme.fontSizeSmall
                  font.family: root.font
                }
              }

              MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onWheel: (wheel) => {
                  brightnessSetProc.command = wheel.angleDelta.y > 0
                    ? ["brightnessctl", "set", "5%+"]
                    : ["brightnessctl", "set", "5%-"];
                  brightnessSetProc.running = true;
                }
              }
            }

            // Battery Widget
            Rectangle {
              height: root.theme.pillHeight
              radius: root.theme.pillRadius
              color: root.theme.bgSurface
              border.color: root.theme.bgBorder
              border.width: 1
              implicitWidth: battRow.implicitWidth + 16

              readonly property color battColor: {
                if (SystemInfo.batteryCharging) return root.theme.accentGreen;
                if (SystemInfo.batteryLevelRaw > 20) return root.theme.batteryGood;
                if (SystemInfo.batteryLevelRaw > 10) return root.theme.batteryWarning;
                return root.theme.batteryCritical;
              }

              Row {
                id: battRow
                anchors.centerIn: parent
                spacing: 6

                Text {
                  anchors.verticalCenter: parent.verticalCenter
                  text: SystemInfo.batteryIcon
                  color: parent.parent.battColor
                  font.pixelSize: 13
                  font.family: root.font
                }

                Text {
                  anchors.verticalCenter: parent.verticalCenter
                  text: SystemInfo.batteryLevel
                  color: root.theme.textPrimary
                  font.pixelSize: root.theme.fontSizeSmall
                  font.family: root.font
                }
              }
            }

            // System Tray
            Rectangle {
              height: root.theme.pillHeight
              radius: root.theme.pillRadius
              color: root.theme.bgSurface
              border.color: root.theme.bgBorder
              border.width: 1
              visible: SystemTray.items.values.length > 0
              implicitWidth: trayRow.implicitWidth + 8

              RowLayout {
                id: trayRow
                anchors.centerIn: parent
                spacing: 4

                Repeater {
                  model: SystemTray.items

                  MouseArea {
                    id: trayDelegate
                    required property SystemTrayItem modelData

                    Layout.preferredWidth: 20
                    Layout.preferredHeight: 20

                    acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

                    onClicked: (mouse) => {
                      if (mouse.button === Qt.LeftButton) {
                        modelData.activate()
                      } else if (mouse.button === Qt.RightButton) {
                        if (modelData.hasMenu) {
                          menuAnchor.open()
                        }
                      } else if (mouse.button === Qt.MiddleButton) {
                        modelData.secondaryActivate()
                      }
                    }

                    IconImage {
                      anchors.centerIn: parent
                      source: trayDelegate.modelData.icon
                      implicitSize: 16
                    }

                    QsMenuAnchor {
                      id: menuAnchor
                      menu: trayDelegate.modelData.menu
                      anchor.window: trayDelegate.QsWindow.window
                      anchor.adjustment: PopupAdjustment.Flip
                      anchor.onAnchoring: {
                        const window = trayDelegate.QsWindow.window;
                        const widgetRect = window.contentItem.mapFromItem(
                          trayDelegate, 0, trayDelegate.height,
                          trayDelegate.width, trayDelegate.height);
                        menuAnchor.anchor.rect = widgetRect;
                      }
                    }
                  }
                }
              }
            }

            // Power Menu Button (Triggers wlogout)
            Rectangle {
              height: root.theme.pillHeight
              width: root.theme.pillHeight
              radius: root.theme.pillRadius
              color: root.theme.bgSurface
              border.color: root.theme.bgBorder
              border.width: 1

              Text {
                anchors.centerIn: parent
                text: "󰐥"
                color: root.theme.accentRed
                font.pixelSize: 13
                font.family: root.font
              }

              MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                onEntered: parent.color = root.theme.bgHover
                onExited: parent.color = root.theme.bgSurface
                onClicked: root.launchCommand("wlogout -b 5")
              }
            }
          }
        }
      }
    }
  }
}