import QtQuick
import QtQuick.Layouts
import ".."

Item {
    id: root

    anchors.fill: parent
    anchors.margins: Theme.barMargin

    // Glassmorphism floating background bar
    Rectangle {
        anchors.fill: parent
        radius: Theme.cornerRadius
        color: Theme.bg
        border.color: Theme.border
        border.width: 1
    }

    // Left section: Workspaces & Active Window Title
    RowLayout {
        anchors.left: parent.left
        anchors.leftMargin: Theme.paddingNormal
        anchors.verticalCenter: parent.verticalCenter
        spacing: Theme.spacing

        Workspaces {}
        ActiveWindow {}
    }

    // Center section: Media Player Controller
    RowLayout {
        anchors.centerIn: parent
        spacing: Theme.spacing

        MediaBar {}
    }

    // Right section: Tray, Stats, Clock, and Power Button
    RowLayout {
        anchors.right: parent.right
        anchors.rightMargin: Theme.paddingNormal
        anchors.verticalCenter: parent.verticalCenter
        spacing: Theme.spacing

        Tray {}
        SystemStats {}
        ClockWidget {}
        PowerMenuButton {}
    }
}
