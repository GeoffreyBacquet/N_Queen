import QtQuick 2.7
import QtQuick.Window 2.3
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4

Item {
    width: 400
    height: 800

    id : root
    property string chemin : "../img/"
    property int indexsolution: 0

    Timer {
        id: idtimer
        interval: 200;
        running: false;
        repeat: true
        onTriggered:{

            if(indexsolution === nombresolution - 1)
            {
                indexsolution = 0
            }
            else
            {
                indexsolution++
            }
            Context.doActionInCpp("navigation", indexsolution)

        }
    }

    GridLayout {
        id: reines
        anchors.fill: parent
        flow:  width > height ? GridLayout.LeftToRight : GridLayout.TopToBottom

        Rectangle{
            id: reinesechequier
            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: true

            Echequier {
                id: rect
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }


        Rectangle{
            id: reinesUI
            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: true

            Column{
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width
                height: parent.height
                spacing: reinesUI.height *.05

                Text{
                    height: reinesUI.height * .10
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pointSize: 18
                    text: "Taille de l'échiquier : " + (1* idcombo.currentText) + " x " + (1* idcombo.currentText)
                }

                Row{

                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: reinesUI.width / 10
                    height: reinesUI.height * .10
                    ComboBox{
                        id: idcombo
                        width:reinesUI.width / 3
                        height: parent.height
                        property int index
                        model: [4,5,6,7,8,9,10,11,12,13,14]
                        style: ComboBoxStyle{
                            background: Rectangle{
                                anchors.fill: parent
                                Image{
                                    source: root.chemin + "GreySquareButton.png"
                                    anchors.fill: parent
                                }
                            }
                        }

                        onCurrentIndexChanged:
                        {
                            idtimer.stop()
                            play.lecture = false
                            idload.visible = true
                            Context.doActionInCpp("entrezTaille",(1* idcombo.currentText))
                            idcombo.focus = false
                            indexsolution = 0
                            text.text = "Cliquez sur une case pour afficher"
                        }
                    }

                    Bouton {
                        height: parent.height
                        width: reinesUI.width / 3
                        MouseArea{
                            anchors.fill: parent
                            onClicked:
                            {
                                stat.visible = true
                                reines.visible = false
                                play.lecture = false
                                idtimer.stop()
                            }
                        }
                        Image{
                            source: root.chemin + "Stats.png"
                            anchors.fill: parent
                        }
                    }
                }

                Bouton{
                    height: reinesUI.height *.10
                    width: reinesUI.width / 3
                    anchors.horizontalCenter: parent.horizontalCenter
                    id:play
                    property bool lecture: false
                    Image{
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        height: parent.height /2
                        width: parent.height /2
                        source: (play.lecture)?  root.chemin + "media-pause-symbol.png": root.chemin + "media-play-symbol.png"
                    }
                    MouseArea{
                        anchors.fill:parent
                        onClicked:
                        {
                            if(play.lecture)
                            {
                                play.lecture = false
                                idtimer.stop()
                            }
                            else
                            {
                                play.lecture = true
                                idtimer.start()
                            }
                        }
                    }
                }

                Row{
                    height: parent.height *.10
                    spacing: reinesUI.width/10
                    anchors.horizontalCenter: parent.horizontalCenter
                    Bouton{
                        visible:(typeof nombresolution === "undefined")? false : (nombresolution > 10)? true : false
                        width:reinesUI.width / 6
                        height: parent.height
                        MouseArea{
                            anchors.fill: parent
                            onClicked:
                            {
                                if(indexsolution - 10 < 0 )
                                {
                                    var temp = indexsolution - 10
                                    indexsolution = nombresolution + temp
                                }
                                else
                                {
                                    indexsolution -= 10
                                }
                                Context.doActionInCpp("navigation", indexsolution)
                            }
                        }
                        Image{
                            height: parent.height / 2
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            fillMode: Image.PreserveAspectFit
                            source: root.chemin + "media-fast-rewind-symbol.png"
                        }
                    }
                    Bouton{
                        width:reinesUI.width / 6
                        height: parent.height
                        MouseArea{
                            anchors.fill: parent
                            onClicked:
                            {
                                if(indexsolution === 0)
                                {
                                    indexsolution = nombresolution - 1
                                }
                                else
                                {
                                    indexsolution--
                                }
                                Context.doActionInCpp("navigation", indexsolution)
                            }
                        }
                        Image{
                            height: parent.height / 2
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            fillMode: Image.PreserveAspectFit
                            source: root.chemin + "media-rewind-symbol.png"
                        }
                    }
                    Bouton{
                        width:reinesUI.width / 6
                        height: parent.height
                        MouseArea{
                            anchors.fill: parent
                            onClicked:
                            {
                                if(indexsolution === nombresolution - 1)
                                {
                                    indexsolution = 0
                                }
                                else
                                {
                                    indexsolution++
                                }
                                Context.doActionInCpp("navigation", indexsolution)
                            }
                        }
                        Image{
                            height: parent.height / 2
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            fillMode: Image.PreserveAspectFit
                            source: root.chemin + "media-forward-symbol.png"
                        }
                    }
                    Bouton{
                        visible:(typeof nombresolution === "undefined")? false : (nombresolution > 10)? true : false
                        width:reinesUI.width / 6
                        height: parent.height
                        MouseArea{
                            anchors.fill: parent
                            onClicked:
                            {
                                if(indexsolution + 10 > nombresolution -1 )
                                {
                                    var temp = indexsolution + 10 - nombresolution
                                    indexsolution = 0 + temp
                                }
                                else
                                {
                                    indexsolution += 10
                                }
                                Context.doActionInCpp("navigation", indexsolution)
                            }
                        }
                        Image{
                            height: parent.height / 2
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            fillMode: Image.PreserveAspectFit
                            source: root.chemin + "media-fast-forward-symbol.png"
                        }
                    }
                }

                ProgressBar{
                    value: (typeof nombresolution === "undefined")? 0 : indexsolution / (nombresolution-1)
                    height: parent.height *.10
                    width: parent.width *.9
                    anchors.horizontalCenter: parent.horizontalCenter
                    minimumValue: 0
                    maximumValue: 1
                    style: ProgressBarStyle{
                        background: Rectangle{
                            anchors.fill: parent
                            Image{
                                source: root.chemin + "GreySquareButton.png"
                                anchors.fill: parent
                            }
                        }
                        progress: Rectangle{
                            anchors.fill: parent
                            color : "transparent"
                            Image{
                                source: root.chemin + "BlueSquareButton.png"
                                anchors.fill:parent


                            }

                        }
                    }

                    Text{
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        text:(typeof solution === 'undefined' || typeof nombresolution === "undefined")? "" : (indexsolution+1) + " / " + nombresolution
                    }
                }

                Rectangle{
                    id: gridpos
                    width: parent.width
                    height: parent.height *.20

                    Grid{
                        anchors.horizontalCenter: parent.horizontalCenter
                        rows:(typeof solution === "undefined")? 0 :  Math.ceil(solution.length / 5)
                        Repeater{
                            model:(typeof solution === "undefined")? 0 : solution.length
                            Position{
                            }
                        }
                    }
                }
            }
        }
    }

    GridLayout {
        id: stat
        visible: false
        anchors.fill: parent
        anchors.margins: 20
        rowSpacing: 20
        columnSpacing: 20
        flow:  width > height ? GridLayout.LeftToRight : GridLayout.TopToBottom

        Rectangle{
            Layout.fillWidth: true
            Layout.fillHeight: true
            id:statechequier


            Column{
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width
                height: parent.height
                spacing: 20
                Grid{
                    id:idgrid
                    width: (parent.width < parent.height)? parent.width : parent.height
                    height: (width === parent.width)? parent.width : parent.height
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    rows: (1* idcombo.currentText)
                    columns: (1* idcombo.currentText)

                    Repeater{
                        model: (1* idcombo.currentText)*(1* idcombo.currentText)

                        Rectangle{
                            id: rect2
                            property color couleur1: (typeof statistique === 'undefined')? "white"
                                                                                         : (statistique[index] === 0) ? "white"
                                                                                                                      : Qt.rgba(.8,
                                                                                                                                1-(statistique[index]-Math.min.apply(null, statistique))/(Math.max.apply(null, statistique)-Math.min.apply(null, statistique)),
                                                                                                                                .25-(statistique[index]-Math.min.apply(null, statistique))/(Math.max.apply(null, statistique)-Math.min.apply(null, statistique)),
                                                                                                                                1)

                            width: idgrid.height/(1* idcombo.currentText)
                            height: idgrid.height/(1* idcombo.currentText)
                            color: couleur1
                            border.width: 1
                            border.color: "black"
                            Text{

                                id: textstat
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter
                                font.pointSize: (parent.height / 4 < 1)? 1 : parent.height /4
                                text:(typeof statistique === 'undefined')? "" :(("" + statistique[index]).length <= 3)? "" + statistique[index] : (("" + statistique[index]).substring(0,("" + statistique[index]).length - 3) + "K")
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked:{
                                    text.text = String.fromCharCode(65 + (index % (1*idcombo.currentText)) )
                                            +(idcombo.currentText - Math.floor(index / (idcombo.currentText * 1)))
                                                                             + " : "  + statistique[index]
                                }
                            }
                        }
                    }
                }
            }
        }
        Rectangle{
            Layout.fillWidth: true
            Layout.fillHeight: true
            id:statUI

            Column{
                spacing : statUI.height / 10
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width

                Text{
                    id: text
                    text:"Cliquer une case pour afficher"
                    font.pointSize: (parent.height / 20 < 1)? 1 : parent.height /20
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text{

                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pointSize: (parent.height / 20 < 1)? 1 : parent.height /20
                    text:(typeof tempsdecalcul === 'undefined')? "" : "Calculé en " + tempsdecalcul + " millisecondes"
                }

                Bouton{
                    width:statUI.width / 3
                    height: statUI.height / 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    MouseArea{
                        anchors.fill: parent
                        onClicked:
                        {
                            reines.visible = true
                            stat.visible = false
                        }
                    }
                    Image{
                        anchors.fill:parent
                        fillMode: Image.PreserveAspectFit
                        source: root.chemin + "echiquier.png"
                    }
                }
            }
        }
    }
    AnimatedImage{
        id: idload
        anchors.fill: parent
        source: root.chemin + "loading.gif"
        opacity: (chargement === "start")? 100 : 0
    }
}

