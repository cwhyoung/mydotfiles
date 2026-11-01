import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick
import Quickshell.Io
import "CustomTheme"
import qs.CustomTheme


PanelWindow {  
    id: bar


         



            anchors{
                left: true
                right: true
                top: true
                }

            margins{
            left: 10
            right: 10
            top: 10
            }

            implicitHeight: 34
            color: Theme.surface
              
                        

            RowLayout {
                //Put items you want on the left side of the bar here
             anchors.left: parent.left 

              
                
                      
            
                        TerminalPanel {}              

                          HyprwsPanel {}
             
                
            }

            RowLayout {
                //Put items you want in the center of the bar here
            
            anchors.centerIn: parent
            spacing: 3 
            
            ClockPanel {}

            SwayvncModule {}
               CalendarPanel {}
            }

            RowLayout {
                //Put items you want on the right side of the bar here
                anchors.right: parent.right
                spacing: 6

                VolumeModule {}

                SystemTrayPanel {}

               // BatteryPanel {}
                
                //VolumePanel {}
                
               // NetworkPanel {}
                
                //LayoutPanel {}   

                CpuPanel {}

                 // Slow timer for system stats
    
    }
                
                }
   

