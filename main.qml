import QtQuick 2.7
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
            PinesRPI{id:pinesRPI}
            Column{
                spacing: app.fs
                Button{
                    text: checked?'Poner Pin 11 en Low':'Poner Pin 11 en High'
                    font.pixelSize: app.fs
                    checkable: true
                    onClicked: {
                        if(!checked){
                            unik.writePinHigh(11)
                        }else{
                            unik.writePinLow(11)
                        }
                    }
                }
            }
        }
    }
    Rectangle{
        id: l1
        width: app.fs*0.1
        height: app.fs*3
        x: pinesRPI.pgp.x+col1.x+pinesRPI.pgp.children[5].x+app.fs-width*0.5
        y: pinesRPI.pgp.y+col1.y-height
        Rectangle{
            id: l2
            width: app.fs*10+app.fs+app.fs*0.5
            height: app.fs*0.1
            anchors.right: parent.right
        }
    }
    Rectangle{
        id: l3
        width: app.fs*0.1
        height: app.fs*2
        x: pinesRPI.pgp.x+col1.x+pinesRPI.pgp.children[4].x+app.fs-width*0.5
        y: pinesRPI.pgp.y+col1.y-height
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
                    id: resp2
                    width: app.fs*3
                    height: width
                    radius: width*0.5
                    anchors.centerIn: resp1
                    color: 'red'
                    opacity: resp1.opacity/2
                }
                Rectangle{
                    id:resp1
                    width: app.fs*2
                    height: width
                    radius: width*0.5
                    anchors.centerIn: pl2
                    color: 'red'
                    Timer{
                        running: true
                        repeat: true
                        interval: 50
                        onTriggered: {
                            parent.opacity=unik.pinIsHigh(11)?0.35:0.0
                        }
                    }
                }
                Rectangle{
                    id:pl1
                    color:'red'
                    width: parent.width+app.fs*0.2
                    height: app.fs*0.7
                    radius: app.fs*0.4
                    anchors.horizontalCenter: parent.horizontalCenter
                    opacity: resp1.opacity>0.0?1.0:0.5
                }
                Rectangle{
                    id:pl2
                    color:'red'
                    width: parent.width+app.fs*0.2
                    height: app.fs*0.6
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: pl1.verticalCenter
                    opacity: resp1.opacity>0.0?1.0:0.5
                }
                Rectangle{
                    id:pl3
                    color:'red'
                    width: parent.width+app.fs*0.4
                    height: app.fs*0.2
                    anchors.top: pl2.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    opacity: resp1.opacity>0.0?1.0:0.5
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
    Shortcut{
        sequence: 'Esc'
        onActivated: Qt.quit()
    }
    Component.onCompleted: {
        unik.initRpiGpio()
        unik.setPinType(11,0)
        unik.setPinState(11, 1)
        unik.setPinType(17,0)
    }
}
