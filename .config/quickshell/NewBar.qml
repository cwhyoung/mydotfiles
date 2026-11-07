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
                            top: true
                            }

                      margins {
                        left: 2
                        right: 2
                        top: 2
                        bottom: 2
                         }

    implicitHeight: background.implicitHeight //Theme.prefSepHeight
   //color: Theme.colBg

    RowLayout {
        Layout.alignment: Qt.AlignLeft
Rectangle {
            id: background
            Layout.alignment: Qt.AlignLeft
            implicitWidth: buttons.implicitWidth
            implicitHeight: buttons.implicitHeight
            radius: height / 2
            color:  Theme.modern_background  || "transparent"
            border.color: Theme.surface

Row {
            padding: 4
            spacing: 6
            anchors.left: parent.left
            id: buttons

        TerminalPanel { anchors.verticalCenter: parent.verticalCenter }
        Hyprws1Panel {anchors.verticalCenter: parent.verticalCenter }
        Rectangle {
            width: 1
            height: Theme.prefSepHeight
            anchors.verticalCenter: parent.verticalCenter
            color: Theme.colWhite
        }
        WindowModeModule { anchors.verticalCenter: parent.verticalCenter }
        Rectangle {
            width: 1
            height: Theme.prefSepHeight
            anchors.verticalCenter: parent.verticalCenter
            color: Theme.colWhite
        }
        ActiveWindowModule { anchors.verticalCenter: parent.verticalCenter }

        //}
    }
    }
    }

    RowLayout {
        anchors.centerIn: parent
        Rectangle {
            anchors.centerIn: parent      
            implicitWidth: centerrow.implicitWidth
            implicitHeight: centerrow.implicitHeight
            color: Theme.modern_background
            border.color: Theme.surface
            radius: height / 2

            Row {
                id: centerrow
                spacing: 6
                padding: 6

                AppLauncher { anchors.verticalCenter: parent.verticalCenter }
                ClockPanel {anchors.verticalCenter: parent.verticalCenter}
                SwayvncModule {anchors.verticalCenter: parent.verticalCenter}
                CalendarPanel {anchors.verticalCenter: parent.verticalCenter}
                }
            }
    }



    RowLayout {
        anchors.right: parent.right
        
        Rectangle {
            Layout.alignment: Qt.AlignRight       
            implicitWidth: rightrow.implicitWidth
            implicitHeight: rightrow.implicitHeight
            color: Theme.modern_background
            border.color: Theme.surface
            radius: height / 2

            Row {
                id: rightrow
                anchors.right: parent.right
                spacing: 6
                padding: 4

                VolumeModule {anchors.verticalCenter: parent.verticalCenter }
                Rectangle {
                width: 1
                height: Theme.prefSepHeight
                anchors.verticalCenter: parent.verticalCenter
                color: Theme.colWhite
                }
                SystemTrayPanel { anchors.verticalCenter: parent.verticalCenter }
                Rectangle {
                width: 1
                height: Theme.prefSepHeight
                anchors.verticalCenter: parent.verticalCenter
                color: Theme.colWhite
                }
                KernelModule { anchors.verticalCenter: parent.verticalCenter }
                Rectangle {
                width: 1
                height: Theme.prefSepHeight
                anchors.verticalCenter: parent.verticalCenter
                color: Theme.colWhite
                visible: UPower.displayDevice.percentage > 0}
                BatteryModule {anchors.verticalCenter: parent.verticalCenter }
                Rectangle {
                width: 1
                height: Theme.prefSepHeight
                anchors.verticalCenter: parent.verticalCenter
                color: Theme.colWhite
                }
                StorageModule {anchors.verticalCenter: parent.verticalCenter }
                Rectangle {
                width: 1
                height: Theme.prefSepHeight
                anchors.verticalCenter: parent.verticalCenter
                color: Theme.colWhite
                }
                MemoryModule {anchors.verticalCenter: parent.verticalCenter }
                Rectangle {
                width: 1
                height: Theme.prefSepHeight
                anchors.verticalCenter: parent.verticalCenter
                color: Theme.colWhite
                }
                CpuPanel {anchors.verticalCenter: parent.verticalCenter }
                Rectangle {
                width: 1
                height: Theme.prefSepHeight
                anchors.verticalCenter: parent.verticalCenter
                color: Theme.colWhite
                }
                PowerModule {anchors.verticalCenter: parent.verticalCenter }
                }
        }
    }
}
SideBar {
    id: sideBar
}
}
