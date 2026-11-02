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

PanelWindow {
    id: bar
                    anchors {
                            left: true
                            right: true
                            top: true
                            }

                      margins {
                        left: 10
                        right: 10
                        top: 10
                         }

    implicitHeight: 34
    color: Theme.colBg || "transparent"

    RowLayout {
        anchors.left: parent.left

        TerminalPanel {}
        HyprwsPanel {}
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
