import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    Layout.fillWidth: true
    Layout.preferredHeight: 50
    color: "#f6f7f8"
    border.color: "#dfe1e6"
    Rectangle {
        color: "#f6f7f8"
        width: 200
        height: parent.height-1
        // Layout.preferredWidth: 300
        // Layout.maximumWidth: 300
        Image {
            id: logoImg
            anchors.centerIn: parent
            // anchors.verticalCenter: parent.verticalCenter
            // anchors.leftMargin: 60
            source: "../static/images/logo.png"
            width: 132
            height: 26
        }
    }
    Rectangle {
        color: "#f6f7f8"
        width: 150
        height: parent.height - 1
        // Layout.preferredWidth: 300
        // Layout.maximumWidth: 300
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.rightMargin: 10
        Image {
            id: userAvatar
            anchors.centerIn: parent 
            // anchors.verticalCenter: parent.verticalCenter
            source: "../static/images/head.png"
            width: 30
            height: 30
        }
        Text {
            id: realNameText
            text: "张三"
            anchors.left: userAvatar.right
            anchors.verticalCenter: parent.verticalCenter
            font.pointSize: 12
            anchors.leftMargin: 5
            anchors.topMargin:11
        }
        MouseArea {
            id: userAvatarMouseArea
            anchors.fill: userAvatar
            onClicked: {
                userMenu.visible =!userMenu.visible;
            }
        }
        // // 点击头像弹出下拉框
        Menu {
            id: userMenu
            title: "系统设置"
            x: userAvatar.x 
            y: userAvatar.y + userAvatar.height + 5
            width: 90
            visible: false
            MenuItem {
                text: "密码设置"
                onClicked: {
                    userEditPopup.open()
                }
            }
            MenuItem {
                text: "退出登录"
                onClicked: {
                    console.log("退出登录")
                }
            }
        }
    }
}