import  Quickshell
import QtQuick

BarButton {
            iconSrc: "shared/icons/launcher.svg"
                onClicked: {
                            Quickshell.execDetached(["sh", "-c", "rofi -show drun -show-icons "])
                            }
                   }