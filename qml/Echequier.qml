import QtQuick 2.7
import QtQuick.Window 2.1
import QtQuick.Controls 1.4


Rectangle{
    width: (parent.width < parent.height)? parent.width : parent.height
    height: (width == parent.width)? parent.width : parent.height
    anchors.centerIn: parent
    Column {
        y: 30
        anchors.fill: parent
         Repeater{
            anchors.fill: parent
            model: 1* idcombo.currentText +1

            Row{
                id: row1
                property int indexLigne: index

                Repeater{
                    anchors.fill: parent
                    model: 1* idcombo.currentText +1

                    Case {
                        numColonne: index
                        numLigne: row1.indexLigne
                        cote: (rect.width - 20)/ (1* idcombo.currentText)
                        width: (numColonne == 0) ? 20 : cote
                        height: (numLigne == 0) ? 20 : cote

                        Text{

                            id: textColonne
                            color: "white"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            visible:(numLigne == 0 && numColonne != 0)? true : false
                            font.pointSize: (parent.height/2 < 1)? 1 : parent.height/2
                            text: String.fromCharCode(64 + numColonne)
                        }
                        Text{
                            id: textLigne
                            color: "white"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            visible:(numLigne != 0 && numColonne == 0)? true : false
                            text: (1* idcombo.currentText +1 - numLigne)
                            font.pointSize: (parent.width/2 < 1)? 1 : parent.width/2
                        }
                    }
                }
            }
        }
    }
}
