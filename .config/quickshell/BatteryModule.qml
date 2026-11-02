import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower
import QtQuick
import qs.CustomTheme

  


                    

    Text {
                        visible: UPower.displayDevice.percentage > 0
                        text: "  " + UPower.displayDevice.percentage * 100 + "%"
                        color: Theme.colPurple
                        font.pixelSize: Theme.fontSize
                        font.family: Theme.fontFamily
                        font.bold: true
                       
         }
            