import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs.CustomTheme

// Root filesystem free storage usage module
Text {
   property int diskUsage: 0

        // Disk usage
            Process {
                id: diskProc
                command: ["sh", "-c", "df / | tail -1"]
                    stdout: SplitParser {
                            onRead: data => {
                                    if (!data) return
                                    var parts = data.trim().split(/\s+/)
                                    var percentStr = parts[4] || "0%"
                                    diskUsage = parseInt(percentStr.replace('%', '')) || 0
                                            }
                                        }
                Component.onCompleted: running = true
            }

           // Slow timer for system stats
            Timer {
                interval: 2000
                running: true
                repeat: true
                    onTriggered: {
                        diskProc.running = true
                                    }
                    }
                        text: "  " + diskUsage + "%"
                        color: Theme.colBlue
                        font.pixelSize: Theme.fontSize
                        font.family: Theme.fontFamily
    }