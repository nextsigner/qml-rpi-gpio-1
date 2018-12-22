import QtQuick 2.0

Rectangle{
    width: gp.width+app.fs
    height: gp.height+app.fs
    color: "#222222"
    border.width: app.fs*0.1
    border.color: 'red'
    property alias pgp: gp
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
                    width: app.fs*2
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
                    width: app.fs*2
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
