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

    implicitHeight: Theme.prefSepHeight
   //color: Theme.colBg || "transparent"

    RowLayout {
        anchors.left: parent.left
Rectangle {
            id: background
            anchors.centerIn: parent
            implicitWidth: buttons.implicitWidth
            implicitHeight: buttons.implicitHeight
            radius: height / 2
            color:  Theme.colBg  || "transparent"  
        
Row { 
            padding: 4
            spacing: 3
            anchors.left: parent.left
            id: buttons

        TerminalPanel {  }

        HyprwsPanel {  }

        Rectangle {
            width: 1
            height: 22
            anchors.verticalCenter: parent.verticalCenter
            color: Theme.colMuted
        }
      
        WindowModeModule {  }
        Rectangle {
            left.margin: 4
            width: 1
            height: 22
            anchors.verticalCenter: parent.verticalCenter
            color: Theme.colMuted
        }
       
        ActiveWindowModule {  }

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