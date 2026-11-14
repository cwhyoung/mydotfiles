import Quickshell
import QtQuick
import qs.CustomTheme

BarButton {
    id: powerbutton
    tooltipText: "Show power menu for Shutdown, Reboot, Screen Lock, Log Out and inhibit sleep"
    iconSrc: "shared/icons/power.svg"
    onClicked: {Theme.sideBarVisible = Theme.sideBarVisible === 0 ? 1 : 0 }
    color: if (Theme.sideBarVisible === 1) {
        Theme.primary_container_active
    } else {
        "transparent"
    } 

Timer {
        interval: 25000
        running: if (Theme.sideBarVisible) {
            running: true
        } else {
            running: false
        }
        onTriggered: {
                       {Theme.sideBarVisible = Theme.sideBarVisible = 0 } 
        }
    }
}