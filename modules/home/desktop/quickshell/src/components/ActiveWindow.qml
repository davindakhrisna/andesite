import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import ".."

Pill {
    id: root

    readonly property string windowTitle: Hyprland.activeWindow ? (Hyprland.activeWindow.title || Hyprland.activeWindow.initialClass || "") : ""
    readonly property bool hasWindow: windowTitle.length > 0

    visible: hasWindow
    hoverable: false

    implicitWidth: Math.min(layout.implicitWidth + Theme.paddingLarge * 2, 280)

    RowLayout {
        id: layout
        anchors.fill: parent
        anchors.leftMargin: Theme.paddingNormal
        anchors.rightMargin: Theme.paddingNormal
        spacing: Theme.spacing

        Text {
            text: "●"
            font.pixelSize: 8
            color: Theme.accentSecondary
            Layout.alignment: Qt.AlignVCenter
        }

        Text {
            Layout.fillWidth: true
            text: root.windowTitle
            font.family: Theme.fontSans
            font.pixelSize: Theme.fontSizeNormal
            color: Theme.text
            elide: Text.ElideRight
            maximumLineCount: 1
            Layout.alignment: Qt.AlignVCenter
        }
    }
}
