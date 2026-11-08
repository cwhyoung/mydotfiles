import Quickshell
import Quickshell.Io
import QtQuick
import Quickshell.Networking
import QtQuick.Layouts
import qs.CustomTheme

  Row {

property string networkName: "Disconnected"
    property string networkIp: "No IP"

    Process {
        id: networkStatusProc
        command: [
            "bash",
            "-c",
            "ssid=$(iwgetid -r 2>/dev/null || echo 'Disconnected'); ip=$(hostname -I 2>/dev/null | awk '{print $1}' || echo 'No IP'); printf 'SSID:%s\\nIP:%s\\n' \"$ssid\" \"$ip\""
        ]
        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;

                const lines = data.split(/\r?\n/).filter((line) => line.length > 0);
                for (const line of lines) {
                    if (line.startsWith("SSID:"))
                        networkName = line.slice(5).trim() || "Disconnected";
                    else if (line.startsWith("IP:"))
                        networkIp = line.slice(3).trim() || "No IP";
                }
            }
        }
        Component.onCompleted: running = true
    }

    Timer {
        interval: 30000
        running: true
        repeat: true
        onTriggered: networkStatusProc.running = true
    }


                SepLine {}
                spacing: 6
                anchors.centerIn: parent


               






                Rectangle {
                    width: 8
                    height: 8
                    radius: 4
                    color: networkName === "Disconnected" ? "#f7768e" : "#9ece6a"
                    border.color: Theme.colBg || "#1a1b26"
                    border.width: 1
                }

                Text {
                    text: networkName === "Disconnected" ? "Offline" : networkName
                    color: Theme.colFg || "#a9b1d6"
                    font.pixelSize: 10
                    font.family: Theme.fontFamily || "JetBrainsMono Nerd Font"
                    elide: Text.ElideRight
                    maximumLineCount: 1
                }

                Text {
                    text: networkIp
                    color: Theme.colMuted || "#444b6a"
                    font.pixelSize: 10
                    font.family: Theme.fontFamily || "JetBrainsMono Nerd Font"
                    visible: networkIp !== "No IP"
                }
            }