import  Quickshell
import QtQuick.Layouts
import QtQuick

Rectangle {
                        Layout.preferredWidth: 24
                        Layout.preferredHeight: 24
                        color: "transparent"

                        Image {
                            anchors.fill: parent
                            source: "shared/icons/terminal.svg"
                            fillMode: Image.PreserveAspectFit
                            
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                Quickshell.execDetached(["sh", "-c", "kitty "])
                            }
                        }
                    }