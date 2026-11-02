import Quickshell
import Quickshell.Io
import QtQuick
import qs.CustomTheme



// Memory usage module
Text {
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
       



                        text: "  " + memUsage + "%"
                        color: Theme.colCyan
                        font.pixelSize: Theme.fontSize
                        font.family: Theme.fontFamily
                        font.bold: true
                        
                    


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