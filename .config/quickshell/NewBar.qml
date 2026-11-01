import Quickshell
import QtQuick.Layouts
import QtQuick
import Quickshell.Io
import "CustomTheme"


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
            color: "transparent"
              
                        

            RowLayout {
                //Put items you want on the left side of the bar here
             anchors.left: parent.left 

             //Rectangle {

               //         color: "black"
                 //       radius: height / 2
                   //     Layout.preferredWidth: TerminalPanel.Width + 6 + HyprwsPanel.Width + 6
            
                     //   implicitWidth: TerminalPanel.Width + 6 + HyprwsPanel.Width + 6
                       // implicitHeight: Theme.prefSepHeight
            
                        TerminalPanel {}              

                          HyprwsPanel {}
             
            // }
            }

            RowLayout {
                //Put items you want in the center of the bar here
            
            anchors.centerIn: parent
            spacing: 3 
            
            ClockPanel {}
                
            }

            RowLayout {
                //Put items you want on the right side of the bar here
                anchors.right: parent.right
                spacing: 6

               // BatteryPanel {}
                
                //VolumePanel {}
                
               // NetworkPanel {}
                
                //LayoutPanel {}   

                CpuPanel {}

                 // Slow timer for system stats
    
    }
                
                }
   

