import QtQuick 2.7
import QtQuick.Window 2.3
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3

Rectangle{
    id: pos
    color: "Black"
    width:(typeof solution === "undefined")? 0 : gridpos.width/5
    height: (typeof solution === "undefined")? 0 : gridpos.height/3

    Row{
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        spacing : 1

        Text{
            color: "White"
            font.pointSize: pos.height *.4

            font.bold: true
            text: String.fromCharCode(65 + index)
        }

        Text{
            color:(text == solution.length)? "Red" : "Yellow"
            font.pointSize: pos.height *.4
            font.bold: true
            text:(solution.length - solution.indexOf(index))

        }
    }
}
