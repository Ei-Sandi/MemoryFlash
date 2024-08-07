import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

Button {
    id: btn
    property string txt: "Default Text"

    contentItem: Label {
        text: btn.txt
        color: "#01295E"
        font.pointSize: 12
        font.bold: btn.hovered ? true: false
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    background: Rectangle {
        implicitWidth: 180
        implicitHeight: 40
        color: "transparent" 
        border.color: "#003780"
        border.width: btn.hovered ? 2 : 1
        radius: 15
    }
}