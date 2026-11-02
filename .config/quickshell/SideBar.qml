import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects
import qs.CustomTheme

PanelWindow {
    id: root

    visible: Theme.sideBarVisible

    // --- WAYLAND CONFIGURATION ---
   // WlrLayershell.layer: WlrLayer.Overlay
   // exclusionMode: WlrLayershell.Ignore

    anchors {
        right: true
        top: true
        bottom: true
    }

    margins {
        left: 2
        right: 2
        top: 2
    }

    color: "transparent" //Theme.colBg || "transparent"


    Rectangle {
        id: background
        anchors.centerIn: parent
        implicitWidth: 50
        implicitHeight: buttons.implicitHeight
        radius: width / 2
        color:  Theme.surface_bright  || "transparent"
        

        Column {
            padding: 10
            spacing: 5
            anchors.centerIn: parent
            id: buttons

            BarButton {
                iconSrc: "shared/icons/power.svg"
             
                onClicked: Quickshell.execDetached(["bash", "-c", "poweroff"])
            }
            BarButton {
                iconSrc: "shared/icons/reboot.svg"
                
                onClicked: Quickshell.execDetached(["bash", "-c", "reboot"])
            }
            BarButton {
                iconSrc: "shared/icons/logout.svg"
                onClicked: Quickshell.execDetached(["bash", "-c", "pkill hypr"])
            }
            BarButton {
                iconSrc: "shared/icons/lock.svg"
                onClicked: Quickshell.execDetached("hyprctl", "dispatch", "lock")
            }
        }
    }
}