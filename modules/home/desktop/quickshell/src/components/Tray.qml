import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import ".."

RowLayout {
    id: root

    spacing: Theme.spacing
    visible: SystemTray.items.values.length > 0

    Repeater {
        model: SystemTray.items.values

        delegate: Pill {
            id: trayItem
            required property SystemTrayItem modelData

            implicitWidth: Theme.pillHeight
            implicitHeight: Theme.pillHeight

            onClicked: {
                if (trayItem.modelData) {
                    trayItem.modelData.activate()
                }
            }

            onRightClicked: {
                if (trayItem.modelData && trayItem.modelData.hasMenu) {
                    trayItem.modelData.openMenu()
                }
            }

            IconImage {
                anchors.centerIn: parent
                implicitWidth: 16
                implicitHeight: 16
                source: trayItem.modelData ? (trayItem.modelData.icon || "") : ""
                visible: source !== ""
            }

            Text {
                anchors.centerIn: parent
                visible: !parent.children[1].visible
                text: "󱊖"
                font.family: Theme.fontMono
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.textMuted
            }
        }
    }
}
