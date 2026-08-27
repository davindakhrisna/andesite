import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Io
import ".."

RowLayout {
    id: root

    spacing: Theme.spacing

    Process {
        id: hyprDispatch
    }

    function switchWorkspace(wsId) {
        hyprDispatch.exec(["hyprctl", "dispatch", "workspace", wsId.toString()])
    }

    Repeater {
        // Show workspaces 1 through 7 (or dynamic if higher exists)
        model: 7

        delegate: Rectangle {
            id: wsButton
            required property int index

            readonly property int wsId: index + 1
            readonly property bool isActive: Hyprland.focusedMonitor && Hyprland.focusedMonitor.activeWorkspace
                ? (Hyprland.focusedMonitor.activeWorkspace.id === wsId)
                : false

            implicitWidth: isActive ? 28 : (wsMouseArea.containsMouse ? 24 : 14)
            implicitHeight: Theme.pillHeight - 6
            radius: Theme.pillRadius

            color: isActive 
                ? Theme.accent 
                : (wsMouseArea.containsMouse ? Theme.pillBgHover : Theme.pillBg)

            border.color: isActive 
                ? Theme.accent 
                : (wsMouseArea.containsMouse ? Theme.borderHover : Theme.border)
            border.width: 1

            Behavior on implicitWidth {
                NumberAnimation { duration: Theme.animNormal; easing.type: Easing.OutCubic }
            }

            Behavior on color {
                ColorAnimation { duration: Theme.animNormal }
            }

            Behavior on border.color {
                ColorAnimation { duration: Theme.animNormal }
            }

            Text {
                anchors.centerIn: parent
                visible: wsButton.isActive || wsMouseArea.containsMouse
                text: wsButton.wsId.toString()
                font.family: Theme.fontSans
                font.pixelSize: Theme.fontSizeSmall
                font.weight: wsButton.isActive ? Font.Bold : Font.Medium
                color: wsButton.isActive ? Theme.textDark : Theme.text
                opacity: (wsButton.isActive || wsMouseArea.containsMouse) ? 1.0 : 0.0

                Behavior on opacity {
                    NumberAnimation { duration: Theme.animFast }
                }
            }

            MouseArea {
                id: wsMouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    root.switchWorkspace(wsButton.wsId)
                }
            }
        }
    }
}
