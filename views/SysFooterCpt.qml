import QtQuick

Rectangle {
    color: "#dfe1e6"
    anchors.fill: parent
    default property var technicalSupportText
    property var versionText
    Text {
        text: `技术支持：${technicalSupportText.text} ${versionText.text}`
        color: "#2e2e2e"
        font.pointSize: 13
        anchors.centerIn: parent
    }
}