import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts
import qs.CustomTheme

  Row {

Rectangle {
                        visible: UPower.displayDevice.percentage > 0
                        Layout.preferredWidth: 1
                        Layout.preferredHeight: Theme.prefSepHeight
                        Layout.alignment: Qt.AlignVCenter
                        Layout.leftMargin: 1
                        Layout.rightMargin: 1
                        color: Theme.colMuted
                    }

    Text {
                        visible: UPower.displayDevice.percentage > 0
                        text: "  " + UPower.displayDevice.percentage * 100 + "%"
                        color: Theme.colPurple
                        font.pixelSize: Theme.fontSize
                        font.family: Theme.fontFamily
                        font.bold: true
                        Layout.rightMargin: 1
         }
            }