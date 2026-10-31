import Quickshell
import QtQuick.Layouts
import QtQuick


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

              TerminalPanel {}              

              HyprwsPanel {}
              
            }

            RowLayout {
                //Put items you want in the center of the bar here
            
            anchors.centerIn: parent
            spacing: 6    
            
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
                
             }
}
