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
            color:  Theme.primary_container  || "transparent"

Row {
            padding: 4
            spacing: 6
            anchors.left: parent.left
            id: buttons

        TerminalPanel { anchors.verticalCenter: parent.verticalCenter }

        Hyprws1Panel {anchors.verticalCenter: parent.verticalCenter }

        Rectangle {
            width: 2
            height: Theme.prefSepHeight
            anchors.verticalCenter: parent.verticalCenter
            color: Theme.colPurple
        }

        WindowModeModule { anchors.verticalCenter: parent.verticalCenter }
        Rectangle {
            width: 2
            height: Theme.prefSepHeight
            anchors.verticalCenter: parent.verticalCenter
            color: Theme.colPurple
        }

        ActiveWindowModule { anchors.verticalCenter: parent.verticalCenter }

        //}
    }
    }
    }

    RowLayout {
        anchors.centerIn: parent
        spacing: 3

        ClockPanel {}
        SwayvncModule {}
        CalendarPanel {}
    }

    RowLayout {
        anchors.right: parent.right
        spacing: 3

        VolumeModule {}
        SepLine {}
        SystemTrayPanel {}
SepLine {}
         KernelModule {}
        SepLine {visible: UPower.displayDevice.percentage > 0}
        BatteryModule {}
        SepLine {}
        StorageModule {}
SepLine {}
                MemoryModule {}


        SepLine {}

        CpuPanel {}
        SepLine {}
        PowerModule {}
    }
}
SideBar {
    id: sideBar
    //visible: Theme.sideBarVisible

}
}
