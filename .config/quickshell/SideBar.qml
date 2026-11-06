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
        left: true
    }

    color: "transparent"

    //Mouse clicks outside pill will close the window
    MouseArea {
        anchors.fill: parent
        enabled: Theme.sideBarVisible
        onClicked: Theme.sideBarVisible = false
    }

    Rectangle {
        id: background
        x: parent.width - 100
        anchors.verticalCenter: parent.verticalCenter
        implicitWidth: 50
        implicitHeight: buttons.implicitHeight
        radius: width / 2
        color:  Theme.surface_bright  || "transparent"
        border.color: Theme.primary_container || "transparent"
        border.width: 6

        //Swallow clicks on Menu to stop pill closing
        MouseArea { anchors.fill: parent}

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
                iconSrc: Theme.inhibit_active ? "shared/icons/coffee-black-mug.svg" : "shared/icons/coffee-outline.svg"
                tooltipText: "Inhibit Sleep"
                    onClicked: {
                        Theme.inhibit_active = !Theme.inhibit_active
                        if (Theme.inhibit_active) {
                            Quickshell.execDetached(["bash", "-c", "/usr/bin/hyprcaffeine on infinite && /usr/bin/hyprcaffeine monitor on" ])
                        } else {
                            Quickshell.execDetached(["bash", "-c", "/usr/bin/hyprcaffeine off && /usr/bin/hyprcaffeine monitor off"])
                        }
                    }
                color: Theme.inhibit_active ? Theme.primary_container_active : "transparent"
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