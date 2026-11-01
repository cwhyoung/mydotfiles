import Quickshell
import QtQuick


BarButton {
    iconSrc: "shared/icons/power.svg"
    onClicked: {
        Quickshell.execDetached(["bash", "-c", "powermenu toggle"])
    }
}
