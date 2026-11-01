import  Quickshell
import QtQuick

BarButton {
            iconSrc: "shared/icons/terminal.svg"
                onClicked: {
                            Quickshell.execDetached(["sh", "-c", "kitty "])
                            }
                   }