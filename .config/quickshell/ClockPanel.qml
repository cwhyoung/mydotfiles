 import Quickshell
 import QtQuick
 import qs.CustomTheme

Text {
     id: clock

   SystemClock {
     id: sysClock
     precision: SystemClock.Minutes
             }   
             
   text:"󰥔  " + Qt.formatDateTime(sysClock.date, "ddd, dd MMM yy - hh:mm AP")
   color: Theme.colWhite
        font {
          weight: 600
          family: Theme.fontFamily
          pixelSize: Theme.fontSize}
}
