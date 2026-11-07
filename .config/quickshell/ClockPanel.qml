 import Quickshell
 import QtQuick

Text {
     id: clock

   SystemClock {
     id: sysClock
     precision: SystemClock.Minutes
             }   
             
   text:"󰥔  " + Qt.formatDateTime(sysClock.date, "ddd, dd MMM yy - hh:mm AP")
   color: "#f5e2c5"
        font {
          weight: 600
          family: "SF Pro Display"
          pixelSize: 15}
}
