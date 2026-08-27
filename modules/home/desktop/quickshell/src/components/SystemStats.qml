import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import ".."

RowLayout {
    id: root

    spacing: Theme.spacing

    property int volumeLevel: 50
    property bool isMuted: false
    property bool isWifiConnected: true
    property string wifiSsid: ""
    property int batteryLevel: 100
    property bool isCharging: false
    property bool hasBattery: false

    // Process for volume management
    Process {
        id: volumeQuery
        command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]
        stdout: SplitParser {
            onRead: (data) => {
                let text = data.trim()
                if (text.startsWith("Volume:")) {
                    let parts = text.split(/\s+/)
                    let vol = parseFloat(parts[1])
                    if (!isNaN(vol)) {
                        root.volumeLevel = Math.round(vol * 100)
                    }
                    root.isMuted = text.includes("[MUTED]")
                }
            }
        }
    }

    Process {
        id: volumeAction
    }

    function changeVolume(delta) {
        let arg = delta > 0 ? "5%+" : "5%-"
        volumeAction.exec(["wpctl", "set-volume", "-l", "1.0", "@DEFAULT_AUDIO_SINK@", arg])
        volumeQuery.running = true
    }

    function toggleMute() {
        volumeAction.exec(["wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle"])
        volumeQuery.running = true
    }

    // Process for battery status
    Process {
        id: batteryQuery
        command: ["sh", "-c", "cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -n1; cat /sys/class/power_supply/BAT*/status 2>/dev/null | head -n1"]
        stdout: SplitParser {
            onRead: (data) => {
                let lines = data.trim().split("\n")
                if (lines.length >= 1 && lines[0].length > 0) {
                    let cap = parseInt(lines[0])
                    if (!isNaN(cap)) {
                        root.hasBattery = true
                        root.batteryLevel = cap
                    }
                }
                if (lines.length >= 2) {
                    root.isCharging = (lines[1].trim() === "Charging" || lines[1].trim() === "Full")
                }
            }
        }
    }

    Timer {
        interval: 3000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            volumeQuery.running = true
            batteryQuery.running = true
        }
    }

    // Volume Pill
    Pill {
        id: volumePill
        implicitWidth: volLayout.implicitWidth + Theme.paddingNormal * 2
        
        onClicked: root.toggleMute()
        onScrollUp: root.changeVolume(5)
        onScrollDown: root.changeVolume(-5)

        RowLayout {
            id: volLayout
            anchors.fill: parent
            anchors.leftMargin: Theme.paddingNormal
            anchors.rightMargin: Theme.paddingNormal
            spacing: Theme.spacing

            Text {
                text: root.isMuted ? "󰝟" : (root.volumeLevel > 50 ? "󰕾" : (root.volumeLevel > 0 ? "󰖀" : "󰕿"))
                font.family: Theme.fontMono
                font.pixelSize: Theme.fontSizeMedium
                color: root.isMuted ? Theme.accentWarning : Theme.accentSecondary
                Layout.alignment: Qt.AlignVCenter
            }

            Text {
                text: root.isMuted ? "Muted" : `${root.volumeLevel}%`
                font.family: Theme.fontMono
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.text
                Layout.alignment: Qt.AlignVCenter
            }
        }
    }

    // Battery Pill (Visible only if battery exists)
    Pill {
        id: batteryPill
        visible: root.hasBattery
        implicitWidth: batLayout.implicitWidth + Theme.paddingNormal * 2
        hoverable: false

        RowLayout {
            id: batLayout
            anchors.fill: parent
            anchors.leftMargin: Theme.paddingNormal
            anchors.rightMargin: Theme.paddingNormal
            spacing: Theme.spacing

            Text {
                text: root.isCharging ? "󰂄" : (root.batteryLevel > 80 ? "󰁹" : (root.batteryLevel > 50 ? "󰂀" : (root.batteryLevel > 20 ? "󰁾" : "󰁺")))
                font.family: Theme.fontMono
                font.pixelSize: Theme.fontSizeMedium
                color: root.batteryLevel <= 20 ? Theme.accentWarning : (root.isCharging ? Theme.accentSuccess : Theme.accent)
                Layout.alignment: Qt.AlignVCenter
            }

            Text {
                text: `${root.batteryLevel}%`
                font.family: Theme.fontMono
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.text
                Layout.alignment: Qt.AlignVCenter
            }
        }
    }
}
