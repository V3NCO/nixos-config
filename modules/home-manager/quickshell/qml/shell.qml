import Quickshell // for PanelWindow
import QtQuick // for Text

// qmllint disable uncreatable-type
PanelWindow {
    color: "transparent"
    Rectangle {
        anchors.fill: parent
        anchors.topMargin: 4
        anchors.leftMargin: 12
        anchors.rightMargin: 12
        anchors.bottomMargin: 0
        topLeftRadius: 0
        bottomRightRadius: 0
        radius: 12
        color: "#F502000F"
        border.width: 2
        border.color: "#F5282636"
    }
    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 48
}
