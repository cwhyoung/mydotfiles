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
    text: (isCharging ? "🔋⚡ " : "  ")
        + Math.round(batteryPercentage * 100) / 100 + "%"
    color: Theme.colPurple
    font.pixelSize: Theme.fontSize
    font.family: Theme.fontFamily
    font.bold: true
}