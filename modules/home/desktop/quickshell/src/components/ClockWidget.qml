import QtQuick
import QtQuick.Layouts
import ".."

Pill {
    id: root

    property string timeString: ""
    property string dateString: ""

    function updateTime() {
        let now = new Date()
        let hours = String(now.getHours()).padStart(2, '0')
        let minutes = String(now.getMinutes()).padStart(2, '0')
        root.timeString = `${hours}:${minutes}`
        
        let options = { weekday: 'short', month: 'short', day: 'numeric' }
        root.dateString = now.toLocaleDateString(Qt.locale(), "ddd, MMM d")
    }

    Component.onCompleted: updateTime()

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: root.updateTime()
    }

    implicitWidth: layout.implicitWidth + Theme.paddingNormal * 2

    RowLayout {
        id: layout
        anchors.fill: parent
        anchors.leftMargin: Theme.paddingNormal
        anchors.rightMargin: Theme.paddingNormal
        spacing: Theme.spacing

        Text {
            text: "󰥔"
            font.family: Theme.fontMono
            font.pixelSize: Theme.fontSizeMedium
            color: Theme.accentMuted
            Layout.alignment: Qt.AlignVCenter
        }

        Text {
            text: root.timeString
            font.family: Theme.fontMono
            font.pixelSize: Theme.fontSizeNormal
            font.weight: Font.Bold
            color: Theme.text
            Layout.alignment: Qt.AlignVCenter
        }

        Rectangle {
            implicitWidth: 1
            implicitHeight: 12
            color: Theme.border
            Layout.alignment: Qt.AlignVCenter
        }

        Text {
            text: root.dateString
            font.family: Theme.fontSans
            font.pixelSize: Theme.fontSizeSmall
            color: Theme.textMuted
            Layout.alignment: Qt.AlignVCenter
        }
    }
}
