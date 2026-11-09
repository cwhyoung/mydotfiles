import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower
import QtQuick
import qs.CustomTheme

Text {
    readonly property real batteryPercentage: UPower.displayDevice
        ? UPower.displayDevice.percentage * 100
        : 0
    readonly property bool isCharging: UPower.displayDevice
        && (UPower.displayDevice.state === UPowerDeviceState.Charging
            || UPower.displayDevice.state === UPowerDeviceState.PendingCharge)

    visible: UPower.displayDevice && UPower.displayDevice.percentage > 0
    text: (isCharging ? "  🔋⚡\n " : "   \n ")
        + Math.round(batteryPercentage * 100) / 100 + "%"
    color: Theme.colPurple
    font.pixelSize: Theme.fontSize - 4
    //width: 40
    font.family: Theme.fontFamily
    maximumLineCount: 2
    wrapMode: Text.Wordwrap
}
