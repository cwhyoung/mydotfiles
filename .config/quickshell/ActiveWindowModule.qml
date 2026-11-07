import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Io
import QtQuick
import qs.CustomTheme

// Active window module
Row {
    id: root
    property string activeWindow: "Window"

      // Active window title
    Process {
        id: windowProc
        command: ["sh", "-c", "hyprctl activewindow -j | jq -r '.title // empty'"]
        stdout: SplitParser {
            onRead: data => {
                if (data && data.trim()) {
                    activeWindow = data.trim()
                }
            }
        }
        Component.onCompleted: running = true
    }

    // Event-based updates for window/layout (instant)
    Connections {
        target: Hyprland
        function onRawEvent(event) {
                        windowProc.running = true
        }
    }

     // Backup timer for window/layout (catches edge cases)
    Timer {
        interval: 200
        running: true
        repeat: true
        onTriggered: {
          
            windowProc.running = true
        }
    }       

Text {
                        text: activeWindow
                        color: Theme.colWhite
                        font.pixelSize: Theme.fontSize - 6
                        font.family: Theme.fontFamily
                        width: 400
                        font.bold: false
                        maximumLineCount: 2
                        wrapMode: Text.WordWrap
}
    }