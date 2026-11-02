import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs.CustomTheme



// Memory usage module
Row {
   property int memUsage: 0

   Process {
        id: memProc
        command: ["sh", "-c", "free | grep Mem"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                var parts = data.trim().split(/\s+/)
                var total = parseInt(parts[1]) || 1
                var used = parseInt(parts[2]) || 0
                memUsage = Math.round(100 * used / total)
            }
        }
        Component.onCompleted: running = true
    }
       
    Rectangle {
                        visible: UPower.displayDevice.percentage > 0
                        Layout.preferredWidth: 1
                        Layout.preferredHeight: Theme.prefSepHeight
                        Layout.alignment: Qt.AlignVCenter
                        Layout.leftMargin: 1
                        Layout.rightMargin: 1
                        color: Theme.colMuted
                    }


Text {
                        text: "  " + memUsage + "%"
                        color: Theme.colCyan
                        font.pixelSize: Theme.fontSize
                        font.family: Theme.fontFamily
                        font.bold: true
                        Layout.rightMargin: 1
                    }


// Slow timer for system stats
    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
                       memProc.running = true
        
        }
    }

    }