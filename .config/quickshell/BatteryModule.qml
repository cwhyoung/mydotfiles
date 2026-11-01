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
                        Layout.preferredHeight: root.prefSepHeight
                        Layout.alignment: Qt.AlignVCenter
                        Layout.leftMargin: 1
                        Layout.rightMargin: 1
                        color: root.colMuted
                    }

    Text {
                        visible: UPower.displayDevice.percentage > 0
                        text: "  " + UPower.displayDevice.percentage * 100 + "%"
                        color: root.colPurple
                        font.pixelSize: root.fontSize
                        font.family: root.fontFamily
                        font.bold: true
                        Layout.rightMargin: 1
         }
            }