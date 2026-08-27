import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris
import ".."

Pill {
    id: root

    readonly property MprisPlayer activePlayer: {
        for (let player of Mpris.players.values) {
            if (player.playbackState === MprisPlaybackState.Playing) return player
        }
        return Mpris.players.values.length > 0 ? Mpris.players.values[0] : null
    }

    readonly property bool isPlaying: activePlayer && activePlayer.playbackState === MprisPlaybackState.Playing
    readonly property string trackText: {
        if (!activePlayer) return ""
        let title = activePlayer.trackTitle || ""
        let artist = activePlayer.trackArtist || (activePlayer.trackArtists ? activePlayer.trackArtists.join(", ") : "")
        if (title.length > 0 && artist.length > 0) {
            return `${artist} - ${title}`
        }
        return title || artist || activePlayer.identity || "Media"
    }

    visible: activePlayer !== null && trackText.length > 0
    implicitWidth: layout.implicitWidth + Theme.paddingNormal * 2
    hoverable: false

    RowLayout {
        id: layout
        anchors.fill: parent
        anchors.leftMargin: Theme.paddingNormal
        anchors.rightMargin: Theme.paddingNormal
        spacing: Theme.spacing

        // Music icon
        Text {
            text: root.isPlaying ? "󰎆" : "󰎇"
            font.family: Theme.fontMono
            font.pixelSize: Theme.fontSizeMedium
            color: root.isPlaying ? Theme.accent : Theme.textMuted
            Layout.alignment: Qt.AlignVCenter
        }

        // Track title & artist
        Text {
            text: root.trackText
            font.family: Theme.fontSans
            font.pixelSize: Theme.fontSizeNormal
            color: Theme.text
            elide: Text.ElideRight
            Layout.maximumWidth: 200
            Layout.alignment: Qt.AlignVCenter
        }

        // Prev button
        Rectangle {
            implicitWidth: 20
            implicitHeight: 20
            radius: 10
            color: prevMouse.containsMouse ? Theme.pillBgHover : "transparent"

            Text {
                anchors.centerIn: parent
                text: "󰒮"
                font.family: Theme.fontMono
                font.pixelSize: Theme.fontSizeSmall
                color: prevMouse.containsMouse ? Theme.text : Theme.textMuted
            }

            MouseArea {
                id: prevMouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: if (root.activePlayer && root.activePlayer.canGoPrevious) root.activePlayer.previous()
            }
        }

        // Play/Pause button
        Rectangle {
            implicitWidth: 20
            implicitHeight: 20
            radius: 10
            color: playMouse.containsMouse ? Theme.pillBgHover : "transparent"

            Text {
                anchors.centerIn: parent
                text: root.isPlaying ? "󰏤" : "󰐊"
                font.family: Theme.fontMono
                font.pixelSize: Theme.fontSizeSmall
                color: playMouse.containsMouse ? Theme.accent : Theme.text
            }

            MouseArea {
                id: playMouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: if (root.activePlayer) root.activePlayer.togglePlaying()
            }
        }

        // Next button
        Rectangle {
            implicitWidth: 20
            implicitHeight: 20
            radius: 10
            color: nextMouse.containsMouse ? Theme.pillBgHover : "transparent"

            Text {
                anchors.centerIn: parent
                text: "󰒭"
                font.family: Theme.fontMono
                font.pixelSize: Theme.fontSizeSmall
                color: nextMouse.containsMouse ? Theme.text : Theme.textMuted
            }

            MouseArea {
                id: nextMouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: if (root.activePlayer && root.activePlayer.canGoNext) root.activePlayer.next()
            }
        }
    }
}
