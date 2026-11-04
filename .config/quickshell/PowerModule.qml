import Quickshell
import QtQuick
import qs.CustomTheme

BarButton {
    property bool pwr_active: false
    id: powerbutton
    iconSrc: "shared/icons/power.svg"
    onClicked: {Theme.sideBarVisible = Theme.sideBarVisible === 0 ? 1 : 0, 
                    pwr_active = true}
    color: if (Theme.sideBarVisible === 1) {
        Theme.primary_container_active
    } else {
        "transparent"
    } 

Timer {
        interval: 25000
        running: if (pwr_active) {
            running: true
        } else {
            running: false
        }
        onTriggered: {
                       {Theme.sideBarVisible = Theme.sideBarVisible = 0 ,
                        pwr_active = false} 
        
        }
    }
}