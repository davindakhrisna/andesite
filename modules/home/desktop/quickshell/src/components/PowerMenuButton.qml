import QtQuick
import Quickshell.Io
import ".."

Pill {
    id: root

    implicitWidth: Theme.pillHeight
    implicitHeight: Theme.pillHeight

    Process {
        id: powerProcess
    }

    onClicked: {
        powerProcess.exec(["wlogout"])
    }

    Text {
        anchors.centerIn: parent
        text: "󰐥"
        font.family: Theme.fontMono
        font.pixelSize: Theme.fontSizeMedium
        color: root.hovered ? Theme.accent : Theme.textMuted
    }
}
