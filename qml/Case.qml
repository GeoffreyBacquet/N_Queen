import QtQuick 2.7

Rectangle {

    property int cote
    property int numLigne
    property int numColonne
    property var imagecase : ((numLigne%2 == 0 && numColonne%2 == 0)||(numLigne%2 != 0 && numColonne%2 != 0)) ? root.chemin + "white.jpg" : root.chemin + "red.jpg"
    property var tab:(typeof solution === 'undefined')? "" : solution/*[indexsolution]*/

    width: cote
    height: cote
    id: idCase
    border.width:(numLigne == 0 && numColonne == 0) ? 0 : 1
    border.color: "black"
    color:(numLigne === 0 && numColonne ===0)? "white" : "brown"
    Image {
        id: idimagecase
        source: (numLigne == 0 || numColonne == 0)? "" : imagecase
        anchors.fill: parent
    }
    Image{
        z:3
        visible: (tab && tab[numLigne-1] === numColonne -1)? true : false
        source: root.chemin + "BlackQueen.png"
        anchors.fill : parent
    }
}

