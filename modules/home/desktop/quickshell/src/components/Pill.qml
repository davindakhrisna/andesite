import QtQuick
import QtQuick.Layouts
import ".."

Rectangle {
    id: root

    property bool active: false
    property bool hoverable: true
    property alias hovered: mouseArea.containsMouse
    signal clicked()
    signal rightClicked()
    signal scrollUp()
    signal scrollDown()

    implicitHeight: Theme.pillHeight
    radius: Theme.pillRadius

    color: active 
        ? Theme.pillBgActive 
        : (hoverable && mouseArea.containsMouse ? Theme.pillBgHover : Theme.pillBg)

    border.color: active 
        ? Theme.borderActive 
        : (hoverable && mouseArea.containsMouse ? Theme.borderHover : Theme.border)
    border.width: 1

    Behavior on color {
        ColorAnimation { duration: Theme.animNormal }
    }

    Behavior on border.color {
        ColorAnimation { duration: Theme.animNormal }
    }

    scale: mouseArea.pressed ? 0.97 : 1.0
    Behavior on scale {
        NumberAnimation { duration: Theme.animFast; easing.type: Easing.OutQuad }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: root.hoverable
        cursorShape: root.hoverable ? Qt.PointingHandCursor : Qt.ArrowCursor
        acceptedButtons: Qt.LeftButton | Qt.RightButton

        onClicked: (mouse) => {
            if (mouse.button === Qt.LeftButton) {
                root.clicked()
            } else if (mouse.button === Qt.RightButton) {
                root.rightClicked()
            }
        }

        onWheel: (wheel) => {
            if (wheel.angleDelta.y > 0) {
                root.scrollUp()
            } else if (wheel.angleDelta.y < 0) {
                root.scrollDown()
            }
        }
    }
}
