import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell.Services.UPower
import QtQuick
import Quickshell.Io
import "CustomTheme"
import qs.CustomTheme
import "WallpaperApp"

ShellRoot {
    id: root
PanelWindow {
    id: bar
    color: "transparent"
                    anchors {
                            left: true
                            right: true
                            bottom: true
                            }

                      margins {
                        left: 1
                        right: 1
                        top: 1
                        bottom: 1
                         }

    implicitHeight: background.implicitHeight //Theme.prefSepHeight
   //color: Theme.colBg

    RowLayout {
        Layout.alignment: Qt.AlignLeft
Rectangle {
            id: background
            Layout.alignment: Qt.AlignCenter
            implicitWidth: buttons.implicitWidth + 20
            implicitHeight: buttons.implicitHeight
            radius: height / 2
            color:  Theme.modern_background  || "transparent"
            border.color: Theme.surface

Row {
            spacing: 4
            anchors.left: parent.left
            id: buttons

            NetworkModuleWip {}

    }
    }
    }

    RowLayout {
        anchors.centerIn: parent
           }




    RowLayout {
        anchors.right: parent.right

       }
    }
}
