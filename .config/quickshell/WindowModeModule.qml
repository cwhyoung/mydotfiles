import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick
import qs.CustomTheme

// Window Mode module
Text {
    property string currentLayout: "Tile"

   // Current layout (Hyprland: dwindle/master/floating)
    Process {
        id: layoutProc
        command: ["sh", "-c", "hyprctl activewindow -j | jq -r 'if .floating then \"Floating\" elif .fullscreen == 1 then \"Fullscreen\" else \"Tiled\" end'"]
        stdout: SplitParser {
            onRead: data => {
                if (data && data.trim()) {
                    currentLayout = data.trim()
                }
            }
        }
        Component.onCompleted: running = true
    }

    // Event-based updates for window/layout (instant)
    Connections {
        target: Hyprland
        function onRawEvent(event) {
                       layoutProc.running = true
        }
    }
     // Backup timer for window/layout (catches edge cases)
    Timer {
        interval: 200
        running: true
        repeat: true
        onTriggered: {
        layoutProc.running = true
        }
    }
                        text: currentLayout
                        color: Theme.colWhite
                        font.pixelSize: Theme.fontSize - 3
                        font.family: Theme.fontFamily
                        font.bold: false
    }