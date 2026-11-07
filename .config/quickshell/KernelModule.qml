import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs.CustomTheme

// Kernel version
Row {
  property string kernelVersion: "Unknown"

Process {
                       
                        id: kernelProc
                        command: ["uname", "-r"]
                        stdout: SplitParser {
                            onRead: data => {
                                if (data) kernelVersion = data.trim()
                                }
                                }
                                Component.onCompleted: running = true
                                }
       
    
                    Text {
                        text: kernelVersion
                        color: Theme.colRed
                        width: 127
                        font.pixelSize: Theme.fontSize - 4
                        font.family: Theme.fontFamily
                        font.bold: false
                        clip: true
                        maximumLineCount: 2
                        wrapMode: Text.WordWrap
                    }
    }