import Quickshell
import QtQuick
import qs.CustomTheme

BarButton {
    iconSrc: "shared/icons/power.svg"
    onClicked: Theme.sideBarVisible = Theme.sideBarVisible === 0 ? 1 : 0   

Timer {
        interval: 9000
        running: true
        repeat: true
        onTriggered: {
                       Theme.sideBarVisible = Theme.sideBarVisible = 0 //=== 0 ? 1 : 0  
        
        }
    }
}