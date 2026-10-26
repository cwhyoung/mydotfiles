import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import Quickshell.Services.UPower
import Quickshell.Services.Pipewire
import QtQuick.Layouts
import QtQuick.Controls


ShellRoot {
    id: root

    // Theme colors
    property color colBg: "#1a1b26"
    property color colFg: "#a9b1d6"
    property color colMuted: "#444b6a"
    property color colCyan: "#0db9d7"
    property color colPurple: "#ad8ee6"
    property color colRed: "#f7768e"
    property color colYellow: "#e0af68"
    property color colBlue: "#7aa2f7"

    // Font
    property string fontFamily: "JetBrainsMono Nerd Font"
    property int fontSize: 18

    // System info properties
    property string kernelVersion: "Linux"
    property int cpuUsage: 0
    property int memUsage: 0
    property int diskUsage: 0
    property int volumeLevel: 0
    property string activeWindow: "Window"
    property string currentLayout: "Tile"
    property int prefSepHeight: 38

    // CPU tracking
    property var lastCpuIdle: 0
    property var lastCpuTotal: 0



// Kernel version
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


 // CPU usage
    Process {
        id: cpuProc
        command: ["sh", "-c", "head -1 /proc/stat"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                var parts = data.trim().split(/\s+/)
                var user = parseInt(parts[1]) || 0
                var nice = parseInt(parts[2]) || 0
                var system = parseInt(parts[3]) || 0
                var idle = parseInt(parts[4]) || 0
                var iowait = parseInt(parts[5]) || 0
                var irq = parseInt(parts[6]) || 0
                var softirq = parseInt(parts[7]) || 0

                var total = user + nice + system + idle + iowait + irq + softirq
                var idleTime = idle + iowait

                if (lastCpuTotal > 0) {
                    var totalDiff = total - lastCpuTotal
                    var idleDiff = idleTime - lastCpuIdle
                    if (totalDiff > 0) {
                        cpuUsage = Math.round(100 * (totalDiff - idleDiff) / totalDiff)
                    }
                }
                lastCpuTotal = total
                lastCpuIdle = idleTime
            }
        }
        Component.onCompleted: running = true
    }

 // Memory usage
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



    // Slow timer for system stats
    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            cpuProc.running = true
            memProc.running = true
            diskProc.running = true
        }
    }

    // Event-based updates for window/layout (instant)
    Connections {
        target: Hyprland
        function onRawEvent(event) {
            windowProc.running = true
            layoutProc.running = true
        }
    }

    // Backup timer for window/layout (catches edge cases)
    Timer {
        interval: 200
        running: true
        repeat: true
        onTriggered: {
            windowProc.running = true
            layoutProc.running = true
        }
    }




PanelWindow {
    anchors {
        top: true
        left: true
        right: true
    }

    color: root.colBg
    implicitHeight: root.prefSepHeight

    RowLayout {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 8
        spacing: 4



Rectangle {
                        Layout.preferredWidth: 24
                        Layout.preferredHeight: 24
                        color: "transparent"

                        Image {
                            anchors.fill: parent
                            source: "file:///home/w/.config/quickshell/icons/btw.png"
                            fillMode: Image.PreserveAspectFit
                        }
                    }

                    Item { width: 1 }


        // workspaces go here
        Repeater {

             model: Hyprland.workspaces

            delegate: Text {
            id: workspacesNumber
            required property var modelData
            readonly property bool isWorkspaceEmpty: !modelData.toplevels.values.length

            Layout.preferredWidth: 24
            horizontalAlignment: Text.AlignHCenter

            text: modelData.id
            font.pixelSize: root.fontSize
            font.bold: true
            color: modelData.focused ? "#89b4fa" : (isWorkspaceEmpty ? "#45475a" : "#cdd6f4")
            font.underline: modelData.active

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                acceptedButtons: Qt.LeftButton
                onClicked: parent.modelData.activate()
            }
        }
    }


Rectangle {
                        Layout.preferredWidth: 1
                        Layout.preferredHeight: root.prefSepHeight
                        Layout.alignment: Qt.AlignVCenter
                        Layout.leftMargin: 1
                        Layout.rightMargin: 2
                        color: root.colMuted
                    }


 Text {
                        text: currentLayout
                        color: root.colFg
                        font.pixelSize: root.fontSize
                        font.family: root.fontFamily
                        font.bold: true
                        Layout.leftMargin: 2
                        Layout.rightMargin: 2
                    }
Rectangle {
                        Layout.preferredWidth: 1
                        Layout.preferredHeight: root.prefSepHeight
                        Layout.alignment: Qt.AlignVCenter
                        Layout.leftMargin: 2
                        Layout.rightMargin: 2
                        color: root.colMuted
                    }


Text {
   // This shows the active window name
                        text: activeWindow
                        color: root.colPurple
                        font.pixelSize: root.fontSize
                        font.family: root.fontFamily
                        font.bold: true
                        Layout.fillWidth: true
                        Layout.leftMargin: 3
                        elide: Text.ElideRight
                        maximumLineCount: 1
                    }
            //model: 10 //Hyprland.workspaces
            //Text { text: modelData.id; color: "#cdd6f4" }

    }










    RowLayout {
        anchors.centerIn: parent
        spacing: 8
    Text {
        text: "󰥔 " + Qt.formatDateTime(clock.date, "ddd, dd MMM yyyy - hh:mm")
        color: root.colCyan
        font.pixelSize: root.fontSize
        font.family: root.fontFamily
        font.bold: true
        }
        // clock goes here
    }







    RowLayout {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 14
        spacing: 16


Rectangle {
                        Layout.preferredWidth: 1
                        Layout.preferredHeight: root.prefSepHeight
                        Layout.alignment: Qt.AlignVCenter
                        Layout.leftMargin: 1
                        Layout.rightMargin: 1
                        color: root.colMuted
                    }


Text {
                        text: kernelVersion
                        color: root.colRed
                        font.pixelSize: root.fontSize
                        font.family: root.fontFamily
                        font.bold: true
                        Layout.rightMargin: 1
                    }
Rectangle {
                        Layout.preferredWidth: 1
                        Layout.preferredHeight: root.prefSepHeight
                        Layout.alignment: Qt.AlignVCenter
                        Layout.leftMargin: 1
                        Layout.rightMargin: 1
                        color: root.colMuted
                    }

 Image {
            Layout.alignment: Qt.AlignVCenter
            source: volume.percent <= 0
                ? "../shared/volume-muted.svg"
                : "../shared/volume.svg"
            sourceSize.width: 18
            sourceSize.height: 18
            width: 18
            height: 18
            fillMode: Image.PreserveAspectFit
layer.enabled: true




        }
    // volume
                        Text {
        text: "Vol " + Math.round((Pipewire.defaultAudioSink?.audio?.volume ?? 0) * 100) + "%"
                        color: root.colPurple
                        font.pixelSize: root.fontSize
                        font.family: root.fontFamily
                        font.bold: true

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                acceptedButtons: Qt.LeftButton
                  onClicked: mouse => {
                if (mouse.button === Qt.RightButton)
                     volume.toggleMute()
            else
                   volume.activate()
                    }
                            onWheel: wheel => volume.step(wheel.angleDelta.y > 0 ? 1 : -1)                                                   }
                        Layout.rightMargin: 1

    }    PwObjectTracker { objects: [Pipewire.defaultAudioSink] }





Rectangle {
                        Layout.preferredWidth: 1
                        Layout.preferredHeight: root.prefSepHeight
                        Layout.alignment: Qt.AlignVCenter
                        Layout.leftMargin: 1
                        Layout.rightMargin: 1
                        color: root.colMuted
                    }

    Text {
                        visible: UPower.displayDevice.percentage > 0
                        text: "Bat " + UPower.displayDevice.percentage * 100 + "%"
                        color: root.colPurple
                        font.pixelSize: root.fontSize
                        font.family: root.fontFamily
                        font.bold: true
                        Layout.rightMargin: 1
         }


Rectangle {
                        visible: UPower.displayDevice.percentage > 0
                        Layout.preferredWidth: 1
                        Layout.preferredHeight: root.prefSepHeight
                        Layout.alignment: Qt.AlignVCenter
                        Layout.leftMargin: 1
                        Layout.rightMargin: 1
                        color: root.colMuted
                    }


Text {
                        text: " Mem: " + memUsage + "%"
                        color: root.colCyan
                        font.pixelSize: root.fontSize
                        font.family: root.fontFamily
                        font.bold: true
                        Layout.rightMargin: 1
                    }

Rectangle {
                        Layout.preferredWidth: 1
                        Layout.preferredHeight: root.prefSepHeight
                        Layout.alignment: Qt.AlignVCenter
                        Layout.leftMargin: 1
                        Layout.rightMargin: 1
                        color: root.colMuted
                    }


Text {
                        text: "Disk: " + diskUsage + "%"
                        color: root.colBlue
                        font.pixelSize: root.fontSize
                        font.family: root.fontFamily
                        font.bold: true
                        Layout.rightMargin: 1
                    }
Rectangle {
                        Layout.preferredWidth: 1
                        Layout.preferredHeight: root.prefSepHeight
                        Layout.alignment: Qt.AlignVCenter
                        Layout.leftMargin: 1
                        Layout.rightMargin: 1
                        color: root.colMuted
                    }


Text {
                        text: "CPU: " + cpuUsage + "%"
                        color: root.colYellow
                        font.pixelSize: root.fontSize
                        font.family: root.fontFamily
                        font.bold: true
                        Layout.rightMargin: 1
                    }

     }

SystemClock {
id: clock
precision: SystemClock.Minutes
}
}
}
