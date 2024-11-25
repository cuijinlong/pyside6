import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: headRoot
    Layout.fillWidth: true
    height: 50
    color: "#f6f7f8"
    border.color: "#dfe1e6"
    signal clicked(router: var, type: real)
    Rectangle {
        id: logoDivId
        // color: "#e92828"
        color: "#f6f7f8"
        height: parent.height-1
        width: 200
        Layout.preferredWidth: 200
        Layout.maximumWidth: 200
        // Image {
        //     id: logoImg
        //     anchors.centerIn: parent
        //     // anchors.verticalCenter: parent.verticalCenter
        //     // anchors.leftMargin: 60
        //     source: "../static/images/logo.png"
        //     width: 132
        //     height: 26
        // }
    }
    Rectangle {
        id: menuDivId
        color: "#f6f7f8"
        Layout.preferredWidth: 500
        Layout.preferredHeight: 50
        Layout.maximumWidth: 800
        height: parent.height - 1
        anchors.top: parent.top
        x: 350
        SysMenuCpt {
            id: menuTabBarId
            onClicked:(path, type) =>{
                console.log("SysHeadCpt", path, "," , type)
                headRoot.clicked(path, type)
            }
        }
    }
    Rectangle {
        id: userAvatarDivId
        color: "#f6f7f8"
        width: 150
        height: parent.height - 1
        Layout.preferredWidth: 150
        Layout.maximumWidth: 150
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.rightMargin: 10
        Image {
            id: userAvatarImg
            anchors.centerIn: parent 
            // anchors.verticalCenter: parent.verticalCenter
            source: "../static/images/head.png"
            width: 30
            height: 30
        }
        Text {
            id: realNameText
            text: "张三"
            anchors.left: userAvatarImg.right
            anchors.verticalCenter: parent.verticalCenter
            font.pointSize: 12
            anchors.leftMargin: 5
            anchors.topMargin:11
        }
        MouseArea {
            id: userAvatarMouseArea
            anchors.fill: userAvatarImg
            onClicked: {
                userMenu.visible =!userMenu.visible;
            }
        }
        // // 点击头像弹出下拉框
        Menu {
            id: userMenu
            title: "系统设置"
            x: userAvatarImg.x 
            y: userAvatarImg.y + userAvatarImg.height + 5
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