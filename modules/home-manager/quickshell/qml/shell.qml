import Quickshell // for PanelWindow
import QtQuick // for Text

// qmllint disable uncreatable-type
PanelWindow {
    color: "transparent"
    Rectangle {
        anchors.fill: parent
        anchors.margins: 6
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

    implicitHeight: 0
}
