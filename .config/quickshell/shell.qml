import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import Quickshell.Services.UPower
import Quickshell.Services.Pipewire
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects
//import qs.customTheme


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
                            source: "icons/btw.png"
                            fillMode: Image.PreserveAspectFit
                        }
                    }

                    Item { width: 1 }


        // workspaces go here
        

      Rectangle {
            width: workspaceRow.implicitWidth
            height: workspaceRow.implicitHeight 
            radius: height / 2
                        color: "#040e0d"
    
    Row {
        id: workspaceRow
        required property var modelData
        spacing : 3

            // Minimum number of workspaces to always display, even when empty. The list
         // still grows beyond this to reveal any higher-numbered workspace that
        // exists (e.g. switching to workspace 6 while this is 5 adds a 6th dot).
        property int minWorkspaces: 5

        // The individual workspace buttons, exposed so StatusbarWindow can splice
      // them into its keyboard-navigation list. Rebuilt whenever workspaces are
     // added or removed.
     property var navButtons: []

     function rebuildNavButtons(): void {
        let a = []
        for (let i = 0; i < rep.count; i++)
            a.push(rep.itemAt(i))
        workspaceRow.navButtons = a
     }

      // The workspace ids to render: 1..N, where N is at least minWorkspaces and
     // extends to cover the highest-numbered workspace that currently exists.
        readonly property var workspaceIds: {
        let maxId = Math.max(1, workspaceRow.minWorkspaces)
        const list = Hyprland.workspaces.values
        for (let i = 0; i < list.length; i++)
            if (list[i].id > maxId)
                maxId = list[i].id
        let ids = []
        for (let id = 1; id <= maxId; id++)
            ids.push(id)
        return ids
     }

     // The live Hyprland workspace for an id, or null when it is empty (Hyprland
     // only tracks workspaces that hold windows or are focused).
     function workspaceById(id: int): var {
        const list = Hyprland.workspaces.values
        for (let i = 0; i < list.length; i++)
            if (list[i].id === id)
                return list[i]
        return null
     }
     
        Repeater {
            id: rep
                model: workspaceRow.workspaceIds

                 onItemAdded: workspaceRow.rebuildNavButtons()
         onItemRemoved: workspaceRow.rebuildNavButtons()

            delegate: Rectangle {
            id: ws
            required property var modelData   // the workspace id (int)
            // Set by StatusbarWindow's keyboard navigation.
            property bool focused: false

            // Whether this workspace is the currently focused one.
            readonly property bool isActive: Hyprland.focusedWorkspace
                && Hyprland.focusedWorkspace.id === ws.modelData
            // Whether the workspace currently holds windows (exists in Hyprland).
            readonly property bool occupied: workspaceRow.workspaceById(ws.modelData) !== null

            // Run this workspace's action (mouse click or keyboard Return).
            // Hyprland with Lua dispatchers ignores the plain "workspace N"
            // string, so branch on usingLua the same way the overview does.
            function activate(): void {
                if (Hyprland.usingLua)
                    Hyprland.dispatch("hl.dsp.focus({workspace = '" + ws.modelData + "'})")
                else
                    Hyprland.dispatch("workspace " + ws.modelData)
            }



            implicitWidth: 26
            implicitHeight: 26
            radius: 13
        

            // Empty, unfocused workspaces are dimmed to set them apart from the
            // ones that hold windows.
            opacity: (ws.isActive || ws.occupied || wsMouse.containsMouse) ? 1 : 0.45
            Behavior on opacity {
                NumberAnimation { duration: 300; easing.type: Easing.OutQuint }
            }

            color: ws.isActive
                ? "#3dd1b0"
                : (wsMouse.containsMouse ? "#0f211f" : "transparent")
            border.color: '#0a8c1c'
            border.width: ws.isActive ? 0 : 1

            // Crossfade the fill between active / hover / inactive states so the
            // background of the active circle fades in and the previous one out.
            Behavior on color {
                ColorAnimation { duration: 500; easing.type: Easing.OutQuint }
            }
            // Fade the outline in/out as the fill takes over on activation.
            Behavior on border.width {
                NumberAnimation { duration: 500; easing.type: Easing.OutQuint }
            }

            // Keyboard-selection ring, distinct from the active-workspace fill.
                Rectangle {
                anchors.fill: parent
                anchors.margins: -3
                radius: width / 2
                color: "transparent"
                border.color: '#0a8c1c'
                border.width: 2
                opacity: ws.focused ? 1 : 0
                Behavior on opacity {
                    NumberAnimation { duration: 150 }
                }
            }

                Text {
                anchors.centerIn: parent
                text: ws.modelData
                color: ws.isActive ?  "#0f211f" :"#3dd1b0" 
                font.family: "SP Pro Display"
                font.pixelSize: 15
                font.weight: 800
                font.bold: true

                    // Match the fill crossfade so the label recolors in step.
                    Behavior on color {
                    ColorAnimation { duration: 500; easing.type: Easing.OutQuint }
                }
            }

                MouseArea {
                id: wsMouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: ws.activate()
                    }
                }
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
                        visible: true
                        text: activeWindow
                        color: root.colPurple
                        font.pixelSize: root.fontSize - 4
                        font.family: root.fontFamily
                        font.bold: true
                        Layout.fillWidth: true
                        Layout.maximumWidth: 400
               //         elide: Text.ElideRight
                        clip: true
                        maximumLineCount: 2
                        wrapMode: Text.WordWrap
                    }

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
                        visible: true
                        Layout.preferredWidth: 1
                        Layout.preferredHeight: root.prefSepHeight
                        Layout.alignment: Qt.AlignVCenter
                        Layout.leftMargin: 1
                        Layout.rightMargin: 1
                        color: root.colMuted
                    }


Text {
                        visible: true
                        text: kernelVersion
                        color: root.colRed
                        font.pixelSize: root.fontSize - 4
                        font.family: root.fontFamily
                        font.bold: true
                        Layout.rightMargin: 1
                //        Layout.fillWidth: true
                        Layout.maximumWidth: 100
               //         elide: Text.ElideRight
                        clip: true
                        maximumLineCount: 2
                        wrapMode: Text.WordWrap

                    }
Rectangle {
                        Layout.preferredWidth: 1
                        Layout.preferredHeight: root.prefSepHeight
                        Layout.alignment: Qt.AlignVCenter
                        Layout.leftMargin: 1
                        Layout.rightMargin: 1
                        color: root.colMuted
                    }



/////Start of Volume Section
Rectangle {
    id: volume

        readonly property PwNode sink: Pipewire.defaultAudioSink
            // The sink's audio binding is only valid once the node is ready and is an
            // audio node; guard every access against it being null.
        readonly property bool ready: sink !== null && sink.ready && sink.audio !== null
        // Current volume as a 0.0–1.0 fraction and its rounded percentage.
            readonly property real level: ready ? sink.audio.volume : 0
     readonly property bool muted: ready ? sink.audio.muted : false
    readonly property int percent: muted ? 0 : Math.round(level * 100)

    // How much one wheel notch / arrow press changes the volume.
    readonly property real stepSize: 0.05

    // Set by the keyboard navigation in StatusbarWindow.
    property bool focused: false
    property bool outputMenuOpen: false
    // Shell command behind the output menu's "More Settings" entry
        // (volume.settingsCommand); empty hides the entry.
        property string settingsCommand: "pavucontrol"

            // Keep the sink's audio (volume/muted) properties live and writable.
            PwObjectTracker { objects: [Pipewire.defaultAudioSink] }

    // Set the volume to an absolute fraction, unmuting first so a scroll/arrow
    // while muted brings the sound back.
    function setVolume(v: real): void {
        if (!ready)
            return
        sink.audio.muted = false
        sink.audio.volume = Math.max(0, Math.min(1, v))
    }

    // Raise (dir > 0) or lower (dir < 0) the volume by one step. Called by the
    // mouse wheel and by the Up/Down keys when this module is keyboard-focused.
    function step(dir: int): void {
        setVolume(level + dir * stepSize)
    }

    // Right click: toggle mute. Pipewire keeps the volume value while muted, so
    // un-muting restores exactly the level from before.
    function toggleMute(): void {
        if (ready)
            sink.audio.muted = !sink.audio.muted
    }

    // Select this sink as default and move all currently playing streams to it.
    function selectSink(node): void {
        if (node === null || node.name === "")
            return
        Pipewire.preferredDefaultAudioSink = node
        // WirePlumber changes the default for new streams. Move existing streams
        // too, so every app follows the output selected here immediately.
        Quickshell.execDetached([
            "bash", "-c",
            'pactl set-default-sink "$1" && pactl list short sink-inputs | cut -f1 | while read id; do pactl move-sink-input "$id" "$1"; done',
            "quickshell-audio-output", node.name
        ])
        outputMenuOpen = false
    }

    // Left click / keyboard Return: show available audio outputs.
    function activate(): void {
        outputMenuOpen = !outputMenuOpen
    }

    // "More Settings" in the output menu: open the configured audio control app.
    function openSettings(): void {
        if (settingsCommand !== "")
            Quickshell.execDetached(["bash", "-c", settingsCommand])
        outputMenuOpen = false
    }

    function closeOutputMenu(): void {
        outputMenuOpen = false
    }

    readonly property bool active: mouseArea.containsMouse || volume.focused

    implicitWidth: row.implicitWidth + 6
    implicitHeight: root.prefSepHeight - 2
    radius: 15

    // Same accent-filled highlight as the other modules on hover/selection.
    color: active ? root.colRed : "transparent"

    // Fade the accent circle in/out like BarButton does.
    Behavior on color {
       ColorAnimation { duration: 500; easing.type: Easing.OutQuint }
    }
RowLayout {
        id: row
        anchors.centerIn: parent
        spacing: 3


 Image {
            Layout.alignment: Qt.AlignVCenter
            source: volume.percent <= 0
               ? "shared/volume-muted.svg"
               : "shared/volume.svg"
            sourceSize.width: 18
            sourceSize.height: 18
            width: 18
            height: 18
            fillMode: Image.PreserveAspectFit
layer.enabled: true
 layer.effect: MultiEffect {
                colorization: 1.0
                colorizationColor: volume.active ? root.colCyan : root.colFg
                Behavior on colorizationColor {
                    ColorAnimation { duration: 500; easing.type: Easing.OutQuint }
                }
    }
}  //end of Image

        Text {
            Layout.alignment: Qt.AlignVCenter
            text: volume.percent + "%"
            color: volume.active ? root.colBg : root.colFg
            font.family: root.fontFamily
            font.pixelSize: root.fontSize
            font.bold: true
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        cursorShape: Qt.PointingHandCursor
        onClicked: mouse => {
            if (mouse.button === Qt.RightButton)
                volume.toggleMute()
            else
                volume.activate()
        }
        onWheel: wheel => volume.step(wheel.angleDelta.y > 0 ? 1 : -1)
        }

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
                        visible: UPower.displayDevice.percentage > 0
                        text: "  " + UPower.displayDevice.percentage * 100 + "%"
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
                        text: "  " + memUsage + "%"
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
                        text: "  " + diskUsage + "%"
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
                        text: " " + cpuUsage + "%"
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
