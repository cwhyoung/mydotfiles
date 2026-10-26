# colors
// Theme colors
property color colBg: "#1a1b26"
property color colFg: "#a9b1d6"
property color colMuted: "#444b6a"
property color colCyan: "#0db9d7"
property color colPurple: "#ad8ee6"
property color colRed: "#f7768e"
property color colYellow: "#e0af68"
property color colBlue: "#7aa2f7"

// Font
property string fontFamily: "JetBrainsMono Nerd Font"
property int fontSize: 14


# anchors

edges: left, right, top, bottom
centres: horizontalCenter, verticalCenter
shortcuts: centerIn, fill
margins: margins, left/right/top/bottom
offsets: horizontalCenterOffset, verticalCenterOffset

# layout

Layout.fillWidth
Layout.fillHeight

Layout.preferredWidth
Layout.preferredHeight

Layout.minimumWidth
Layout.minimumHeight

Layout.alignment - Qt.AlignmentVCenter / Qt.AlignRight
