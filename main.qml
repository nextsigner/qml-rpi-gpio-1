import QtQuick 2.0
import QtQuick.Controls 2.0

ApplicationWindow {
    id: app
    visible: true
    visibility: 'Maximized'
    width: 400
    height: 500
    color: 'black'
    property int fs: width*0.02
    Item{
        id: xApp
        anchors.fill: parent
        Column{
            id:col1
            anchors.centerIn: parent
            spacing: app.fs
            Rectangle{
                width: gp.width+app.fs
                height: gp.height+app.fs
                color: "#222222"
                border.width: app.fs*0.1
                border.color: 'red'

                Grid{
                    id: gp
                    anchors.centerIn: parent
                    spacing: app.fs*0.2
                    columns: 20
                    Repeater{
                        //       1 2    3 4   5 6    7 8   9 10   11 12  13 14   15 16  17 18  19 20  21 22  23 24   25 26   27 28  29 30   31 32  33 34   35 36  37 38  39 40
                        model: [[0,0], [0,0],[0,-1],[0,0],[-1,0], [0,0], [0,-1], [0,0], [1,0], [0,-1], [0,0], [0,0], [-1,0], [0,0], [0,-1], [0,0], [0,-1], [0,0], [0,0], [-1,0]]
                        Column{
                            spacing: app.fs*0.2
                            Rectangle{
                                width: app.fs
                                height: width
                                radius: width*0.5
                                border.width: 4
                                border.color: modelData[0]===-1?'white':(modelData[0]===1?'green':'orange')
                                color: modelData[0]===-1?'black':(modelData[0]===1?'orange':'white')
                                Text {
                                    text: '<b>'+parseInt(index*2+1)+'</b>'
                                    font.pixelSize: parent.width*0.4
                                    anchors.centerIn: parent
                                    color: parent.border.color
                                }
                            }
                            Rectangle{
                                width: app.fs
                                height: width
                                radius: width*0.5
                                border.width: 4
                                border.color: modelData[1]===-1?'white':(modelData[1]===1?'green':'orange')
                                color: modelData[1]===-1?'black':(modelData[1]===1?'orange':'white')
                                Text {
                                    text: '<b>'+parseInt(index*2+2)+'</b>'
                                    font.pixelSize: parent.width*0.4
                                    anchors.centerIn: parent
                                    color: parent.border.color
                                }
                            }
                        }
                    }
                }
            }
            Column{
                spacing: app.fs
                Rectangle{
                    width: app.fs*2
                    height: width
                    radius: app.fs*0.5
                    border.width: 2
                    border.color: 'white'
                    Timer{
                        running: true
                        repeat: true
                        interval: 100
                        onTriggered: {
                            //console.log('Boton del Pin 17 esta presionado: '+unik.pinIsHigh(17))
                            parent.color= unik.pinIsHigh(17)?'gray':'red'

                        }
                    }
                }
                Button{
                    text: 'Pin 16'
                    font.pixelSize: app.fs
                    checkable: true
                    //checked: unik.pinIsHigh(16)
                    onClicked: {
                        if(checked){
                            unik.setPinState(16, 0)
                        }else{
                            unik.setPinState(16, 1)
                        }
                    }
                    Timer{
                        running: parent.checked
                        repeat: true
                        interval: 1000
                        onTriggered: {
                            unik.setPinState(16,1)
                        }
                    }
                }
            }
        }
    }
    Rectangle{
        id: l1
        width: app.fs*0.1
        height: app.fs*2
        x: gp.x+col1.x+gp.children[5].x+app.fs*0.5-width*0.5
        y: gp.y+col1.y-height
        Rectangle{
            id: l2
            width: app.fs*10+app.fs*0.5
            height: app.fs*0.1
            anchors.right: parent.right
        }
    }
    Rectangle{
        id: l3
        width: app.fs*0.1
        height: app.fs
        x: gp.x+col1.x+gp.children[4].x+app.fs*0.5-width*0.5
        y: gp.y+col1.y-height
        Rectangle{
            id: l4
            width: app.fs*10
            height: app.fs*0.1
            anchors.right: parent.right
        }
        Rectangle{
            id: l5
            width: app.fs*0.1
            height: app.fs
            anchors.left: l4.left
            anchors.bottom: parent.top
            Rectangle{
                id: xLed1
                color:'transparent'
                width: app.fs+app.fs*0.3-app.fs*0.5
                height: app.fs*3
                anchors.bottom: l5.top
                anchors.left:  parent.left
                Rectangle{
                    id:pl1
                    color:'red'
                    width: parent.width+app.fs*0.2
                    height: app.fs*0.7
                    radius: app.fs*0.4
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Rectangle{
                    id:pl2
                    color:'red'
                    width: parent.width+app.fs*0.2
                    height: app.fs*0.6
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: pl1.verticalCenter
                }
                Rectangle{
                    id:pl3
                    color:'red'
                    width: parent.width+app.fs*0.4
                    height: app.fs*0.2
                    anchors.top: pl2.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Rectangle{
                    color:'white'
                    width: 2
                    anchors.top: pl3.bottom
                    anchors.bottom: parent.bottom
                }
                Rectangle{
                    color:'white'
                    width: 2
                    anchors.top: pl3.bottom
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                }
            }
        }

    }
    Component.onCompleted: {
        unik.initRpiGpio()
        unik.setPinType(16,1)
        unik.setPinType(17,0)
        //l1.parent=gp.children[0]
    }
}
