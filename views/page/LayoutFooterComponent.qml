import QtQuick

Rectangle {
    color: "#073664"
    anchors.fill: parent
    default property var technicalSupportText
    property var versionText
    Text {
        text: `技术支持：${technicalSupportText.text} ${versionText.text}`
        color: "#ffffff"
        font.pointSize: 13
        anchors.centerIn: parent
    }
}