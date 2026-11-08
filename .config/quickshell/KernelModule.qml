import Quickshell
import Quickshell.Io
import QtQuick
import qs.CustomTheme

// Kernel version
Text {
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
