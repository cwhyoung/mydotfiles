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
    WlrLayershell.layer: WlrLayer.Overlay
    exclusionMode: WlrLayershell.Ignore

    anchors {
        right: true
        top: true
        bottom: true
    }

    margins {
        left: 2
        right: 2
        top: 50
    }

    color: "transparent" //Theme.colBg || "transparent"


    Rectangle {
        id: background
        anchors.centerIn: parent
        implicitWidth: 50
        implicitHeight: buttons.implicitHeight
        radius: width / 2
        color:  Theme.surface_bright  || "transparent"
        border.color: Theme.primary_container || "transparent"
        border.width: 6



        Column {
            padding: 15
            spacing: 5
            anchors.centerIn: parent
            id: buttons

            BarButton {
                iconSrc: "shared/icons/power.svg"
                tooltipText: "Power Off"
                onClicked: Quickshell.execDetached(["bash", "-c", "hyprshutdown -t 'Shutting down' --post-cmd 'poweroff'"])
            }
            BarButton {
                iconSrc: "shared/icons/reboot.svg"
                tooltipText: "Reboot"
                onClicked: Quickshell.execDetached(["bash", "-c", "hyprshutdown -t 'Restarting...' --post-cmd 'reboot'"])
            }
            BarButton {
                iconSrc: "shared/icons/suspend.svg"
                tooltipText: "Suspend"
                onClicked: Quickshell.execDetached(["bash", "-c", "systemctl hibernate"])
            }
               BarButton {
                id: inhibitbutton
                property bool inhibit_active: false
                iconSrc: "shared/icons/theme.svg"
                tooltipText: "Inhibit Sleep"
                    onClicked: {
                        inhibit_active = !inhibit_active
                        if (inhibit_active) {
                            Quickshell.execDetached(["bash", "-c", "/usr/bin/hyprcaffeine on infinite"])
                        } else {
                            Quickshell.execDetached(["bash", "-c", "/usr/bin/hyprcaffeine off"])
                        }
                    }
                color: inhibit_active ? Theme.primary_container : "transparent"
            }
            BarButton {
                iconSrc: "shared/icons/logout.svg"
                tooltipText: "Logout"
                onClicked: Quickshell.execDetached(["bash", "-c", "hyprctl dispatch 'hl.dsp.exit()'"])
            }
            BarButton {
                iconSrc: "shared/icons/lock.svg"
                tooltipText: "Lock Screen"
                onClicked: Quickshell.execDetached(["bash", "-c", "hyprlock"])
            }
        }
    }


}
