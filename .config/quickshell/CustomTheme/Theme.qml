pragma Singleton
import Quickshell
import QtQuick
import QtQuick.Io


QtObject {
    id: root


/ Theme colors
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


}