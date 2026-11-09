import Quickshell
import Quickshell.Io
import QtQuick
import Quickshell.Networking
import QtQuick.Layouts
import qs.CustomTheme

Row {
    id: root
    spacing: 6

    property var wifiDevice: Networking.devices.values.find(d => d.type === DeviceType.Wifi)
    property var activeWifi: wifiDevice ? wifiDevice.networks.values.find(n => n.connected) : null
    property string wiredInterface: ""
    property string wiredConnectionName: ""
    readonly property string activeInterfaceName: wiredInterface || (activeWifi && wifiDevice ? wifiDevice.name : "")
    property real downloadBytesPerSecond: 0
    property real uploadBytesPerSecond: 0
    property real previousReceiveBytes: -1
    property real previousTransmitBytes: -1
    property double previousSampleTime: 0

    readonly property real signal: activeWifi ? activeWifi.signalStrength : 0

    readonly property string icon: {
        if (!Networking.wifiEnabled) return String.fromCodePoint(0xF05AA)
        if (!activeWifi) return String.fromCodePoint(0xF092D)

        let tier = signal >= 0.75 ? 4
                 : signal >= 0.50 ? 3
                 : signal >= 0.25 ? 2
                 : 1
        return String.fromCodePoint(0xF091F + (tier - 1) *3)
    }

    function formatRate(bytesPerSecond) {
        if (bytesPerSecond < 1024) return Math.round(bytesPerSecond) + " B/s"
        if (bytesPerSecond < 1024 * 1024) return (bytesPerSecond / 1024).toFixed(1) + " KB/s"
        return (bytesPerSecond / (1024 * 1024)).toFixed(1) + " MB/s"
    }

    Process {
        id: wiredProcess
        command: ["nmcli", "-t", "--escape", "no", "-f", "DEVICE,TYPE,STATE,CONNECTION", "device", "status"]
        stdout: StdioCollector {
            onStreamFinished: {
                let interfaceName = ""
                let connectionName = ""

                for (const line of text.trim().split("\n")) {
                    const fields = line.split(":")
                    if (fields.length < 4 || fields[1] !== "ethernet" || !fields[2].startsWith("connected")) continue

                    interfaceName = fields[0]
                    connectionName = fields.slice(3).join(":")
                    break
                }

                root.wiredInterface = interfaceName
                root.wiredConnectionName = connectionName
            }
        }
        Component.onCompleted: running = true
    }

    Timer {
        interval: 3000
        running: true
        repeat: true
        onTriggered: wiredProcess.running = true
    }

    Process {
        id: trafficProcess
        command: ["cat", "/proc/net/dev"]
        stdout: StdioCollector {
            onStreamFinished: {
                const interfaceName = root.activeInterfaceName
                if (!interfaceName) return

                const line = text.split("\n").find(entry => {
                    const separator = entry.indexOf(":")
                    return separator >= 0 && entry.slice(0, separator).trim() === interfaceName
                })
                if (!line) return

                const counters = line.slice(line.indexOf(":") + 1).trim().split(/\s+/)
                const receiveBytes = Number(counters[0])
                const transmitBytes = Number(counters[8])
                const now = Date.now()

                if (!Number.isFinite(receiveBytes) || !Number.isFinite(transmitBytes)) return
                if (root.previousReceiveBytes >= 0 && root.previousTransmitBytes >= 0 && root.previousSampleTime > 0) {
                    const elapsed = (now - root.previousSampleTime) / 1000
                    if (elapsed > 0) {
                        root.downloadBytesPerSecond = Math.max(0, receiveBytes - root.previousReceiveBytes) / elapsed
                        root.uploadBytesPerSecond = Math.max(0, transmitBytes - root.previousTransmitBytes) / elapsed
                    }
                }

                root.previousReceiveBytes = receiveBytes
                root.previousTransmitBytes = transmitBytes
                root.previousSampleTime = now
            }
        }
        Component.onCompleted: running = true
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: trafficProcess.running = true
    }

    onActiveInterfaceNameChanged: {
        previousReceiveBytes = -1
        previousTransmitBytes = -1
        previousSampleTime = 0
        downloadBytesPerSecond = 0
        uploadBytesPerSecond = 0
        if (activeInterfaceName) trafficProcess.running = true
    }

Text {
         text: root.icon
         visible: !!root.activeWifi
         color: Networking.wifiEnabled ? Theme.colPurple : Theme.colWhite
         font.weight: 600
         font.family: "JetBrainsMono Nerd Font Propo" //Theme.fontFamily
         font.pixelSize: Theme.fontSize
        }


Column {
    spacing: 0

    Text {
    visible: !!root.activeWifi
    anchors.right: parent.right
    text: {
        return root.activeWifi.name
    }
     color: Theme.colWhite
    font {

    family: Theme.fontFamily
    weight: 500 }
}

    Text {
        text: root.wiredConnectionName
        anchors.right: parent.right
        visible: !!root.wiredInterface
        color: Theme.colWhite
        font.family: Theme.fontFamily
        font.weight: 500
    }

    Text {
        text: root.activeInterfaceName
            ? "↓ " + root.formatRate(root.downloadBytesPerSecond) + "  ↑ " + root.formatRate(root.uploadBytesPerSecond)
            : ""
        visible: !!root.activeInterfaceName
        color: Theme.colWhite
        font.family: Theme.fontFamily
        font.weight: 500
    }
}
}
