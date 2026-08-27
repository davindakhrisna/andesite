import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import ".."

Scope {
  id: root
  property var theme: Theme
  property string font: Theme.font

  property bool showVolume: false
  property bool showBrightness: false
  property real volumeValue: 0
  property bool volumeMuted: false
  property real brightnessValue: 0
  property real maxBrightness: 1
  property bool _brightnessReady: false

  // PipeWire tracking
  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink]
  }

  Connections {
    target: Pipewire.defaultAudioSink?.audio ?? null

    function onVolumeChanged() {
      root.volumeValue = Pipewire.defaultAudioSink.audio.volume;
      root.showVolume = true;
      root.showBrightness = false;
      volumeHideTimer.restart();
    }

    function onMutedChanged() {
      root.volumeMuted = Pipewire.defaultAudioSink.audio.muted;
      root.showVolume = true;
      root.showBrightness = false;
      volumeHideTimer.restart();
    }
  }

  Timer {
    id: volumeHideTimer
    interval: 1500
    onTriggered: root.showVolume = false
  }

  // Brightness monitoring
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
        if (!isNaN(val) && root.maxBrightness > 0) {
          root.brightnessValue = val / root.maxBrightness;
          if (root._brightnessReady) {
            root.showBrightness = true;
            root.showVolume = false;
            brightnessHideTimer.restart();
          }
          root._brightnessReady = true;
        }
      }
    }
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
          if (!isNaN(max) && max > 0) root.maxBrightness = max;
          brightnessFile.path = lines[0];
          brightnessReadProc.running = true;
        }
      }
    }
  }

  Timer {
    id: brightnessHideTimer
    interval: 1500
    onTriggered: root.showBrightness = false
  }

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: osdWindow
      required property var modelData
      screen: modelData

      visible: root.showVolume || root.showBrightness
      focusable: false
      color: "transparent"

      WlrLayershell.layer: WlrLayer.Overlay
      WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
      WlrLayershell.namespace: "quickshell-osd"

      exclusionMode: ExclusionMode.Ignore
      mask: Region {}

      anchors {
        top: true
        bottom: true
        left: true
        right: true
      }

      // Center Overlay Card
      Rectangle {
        id: osdCard
        anchors.centerIn: parent
        width: 220
        height: 70
        radius: root.theme.cornerRadius + 4
        color: root.theme.bgOverlay
        border.color: root.theme.bgBorder
        border.width: 1

        opacity: (root.showVolume || root.showBrightness) ? 1.0 : 0.0
        scale: (root.showVolume || root.showBrightness) ? 1.0 : 0.92

        Behavior on opacity { NumberAnimation { duration: root.theme.animFast; easing.type: Easing.OutQuad } }
        Behavior on scale { NumberAnimation { duration: root.theme.animFast; easing.type: Easing.OutBack } }

        ColumnLayout {
          anchors.fill: parent
          anchors.margins: 14
          spacing: 8

          // Header: Icon + Name + Percentage
          RowLayout {
            Layout.fillWidth: true

            Text {
              text: {
                if (root.showVolume) {
                  if (root.volumeMuted || root.volumeValue <= 0) return "󰖁";
                  if (root.volumeValue < 0.33) return "󰕿";
                  if (root.volumeValue < 0.66) return "󰖀";
                  return "󰕾";
                }
                return "󰃠";
              }
              color: root.showVolume
                ? (root.volumeMuted ? root.theme.textMuted : root.theme.accentPrimary)
                : root.theme.accentYellow
              font.pixelSize: 18
              font.family: root.font
            }

            Text {
              Layout.fillWidth: true
              text: root.showVolume ? "Volume" : "Brightness"
              color: root.theme.textPrimary
              font.bold: true
              font.pixelSize: root.theme.fontSizeNormal
              font.family: root.font
            }

            Text {
              text: {
                if (root.showVolume) {
                  return root.volumeMuted ? "Muted" : Math.round(root.volumeValue * 100) + "%";
                }
                return Math.round(root.brightnessValue * 100) + "%";
              }
              color: root.theme.textSecondary
              font.pixelSize: root.theme.fontSizeSmall
              font.family: root.font
            }
          }

          // Progress Bar
          Rectangle {
            Layout.fillWidth: true
            height: 6
            radius: 3
            color: root.theme.bgSurface
            border.color: root.theme.bgBorder
            border.width: 1
            clip: true

            Rectangle {
              anchors.top: parent.top
              anchors.bottom: parent.bottom
              anchors.left: parent.left
              width: parent.width * Math.max(0, Math.min(1.0, root.showVolume
                ? (root.volumeMuted ? 0 : root.volumeValue)
                : root.brightnessValue))
              radius: 3
              color: root.showVolume
                ? (root.volumeMuted ? root.theme.textMuted : root.theme.accentPrimary)
                : root.theme.accentYellow

              Behavior on width { NumberAnimation { duration: 80; easing.type: Easing.OutCubic } }
            }
          }
        }
      }
    }
  }
}
