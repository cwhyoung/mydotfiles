import Quickshell
import QtQuick
import qs.CustomTheme

BarButton {
    iconSrc: "shared/icons/power.svg"
    onClicked: Theme.sideBarVisible = Theme.sideBarVisible === 0 ? 1 : 0   
}