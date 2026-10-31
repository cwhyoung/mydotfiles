 import Quickshell
 import QtQuick


  Rectangle {
    id: clockPanel
            color: "#040e0d"
            width: clock.implicitWidth + 22
            height: clock.implicitHeight + 10
            radius: height / 2

                Text {
                id: clock

                    SystemClock {
                    id: sysClock
                    precision: SystemClock.Minutes
                    }   
             
                   text:"󰥔  " + Qt.formatDateTime(sysClock.date, "ddd, dd MMM yy - hh:mm AP")
                   color: "#f5e2c5"
                   anchors.centerIn: parent

                    font {
                    weight: 600
                    family: "SF Pro Display"
                    pixelSize: 15}
                }
        }