import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: root
    width: 1400
    height: 900
    color: "#ffffff"
    visible: true
    
    // 头部布局
    RowLayout {
        id: headerLayout
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 6
        LayoutHeadComponent {

        }
    }

    // 中间布局
    RowLayout {
        id: middleLayout
        anchors.left: parent.left
        anchors.right: parent.right
        y: headerLayout.height
        // 菜单布局
        LayoutMenuComponent {
            id: menuDrawer
            width: 200
            height: root.height - headerLayout.height - 30
            y: headerLayout.height + 10
            color: "#f6f7f8"
            anchors.left: parent.left
            leftMargin: 0
            onClicked:(router, type) =>{
                console.log(router, "," , type)
            }
            Component.onCompleted: {
                console.log(menuDrawer.width)
            }
        }
       
        // 主窗口布局
        Rectangle {
            id: mainContent
            width: parent.width
            height: parent.height
            color: "#fafbfc"
            anchors.left: menuDrawer.right
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
             // 主窗口内容
            Rectangle {
                id: mainContainer
                width: root.width - menuDrawer.width
                height: root.height - headerLayout.height - 30
                anchors.left: drawArrow.right - 10
                color: "#fafbfc"
                // color: "#ee1111"
                transform: Translate {
                    id: mainTranslate
                    x: 0
                    Behavior on x {
                        NumberAnimation {
                            duration: 400;
                            easing.type: Easing.OutQuad
                        }
                    }
                }
                Text {
                    text: "aaaaaaaaaaaaaaa"
                    anchors.centerIn: mainContent
                }
            }
            // 收缩箭头按钮
            Rectangle {
                id: drawArrow
                width: 12
                height: 60
                color: "#2fc1e1"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                transform: Translate {
                    id: drawArrowTranslate
                    x: 0
                    Behavior on x {
                        NumberAnimation {
                            duration: 400;
                            easing.type: Easing.OutQuad
                        }
                    }
                }
                Text {
                    id: drawArrowText
                    text: "<"
                    color: "#ffffff"
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.centerIn: parent
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: { parent.color="#0883d8" }
                    onExited: { parent.color="#2fc1e1" }
                    onClicked: {
                        menuDrawer.bMenuShown = !menuDrawer.bMenuShown;
                        if(menuDrawer.bMenuShown) {
                            menuDrawer.menuTranslateX = 0
                            drawArrowTranslate.x = 0
                            mainTranslate.x = 0
                            drawArrowText.text="<"
                            resizeTimer.start()
                        }else {
                            mainContainer.width = root.width
                            menuDrawer.menuTranslateX = -200
                            drawArrowTranslate.x = -200
                            mainTranslate.x = -200
                            drawArrowText.text=">"
                        }
                    }
                    Timer {
                        id: resizeTimer
                        interval: 1000
                        repeat: false
                        onTriggered: {
                            mainContainer.width = root.width - menuDrawer.width
                        }
                    }
                }
            }
        }
    }
    // 底部布局
    RowLayout {
        id: footLayout
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 30
        LayoutFooterComponent {
            technicalSupportText: Text {text: "通达数据"}
            versionText: Text {text: "C（2022）0000043"}
        }
    }

    Popup {
        id: userEditPopup
        width: 800
        height: 400
        dim: true
        modal: true
        anchors.centerIn: parent
        // closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
        closePolicy: Popup.CloseOnEscape
        clip: true
        focus: true
        contentItem: Rectangle {
            color: "lightblue"
            radius: 5
            Text {
                text: "This is a popup window."
                anchors.centerIn: parent
            }
        }
    }
    


        // Rectangle {
        //     Layout.fillHeight: true
        //     color: "blue"
        //     Layout.minimumWidth: 50
        //     Layout.preferredWidth: 100
        //     Layout.maximumWidth: 300
        //     Layout.minimumHeight: 150
        //     Text {
        //         anchors.centerIn: parent
        //         text: parent.width + 'x' + parent.height
        //     }
        // }
        // 头部左侧：Logo和标题
        // Image {
        //     id: logo
        //     source: "logo.png"
        //     width: 40
        //     height: 40
        //     Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
        // }
        // Text {
        //     id: title
        //     text: "系统管理框架"
        //     font.pointSize: 16
        //     Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
        //     Layout.leftMargin: 10
        // }

        // // 头部右侧：用户头像和登录名称
        // Image {
        //     id: userAvatar
        //     source: "user_avatar.png"
        //     width: 30
        //     height: 30
        //     Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
        //     Layout.rightMargin: 20
        // }
        // Text {
        //     id: userLoginName
        //     text: "用户名"
        //     font.pointSize: 14
        //     Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
        //     Layout.rightMargin: 5
        // }

        // // 点击头像弹出下拉框
        // Menu {
        //     id: userMenu
        //     title: ""
        //     x: userAvatar.x + userAvatar.width
        //     y: userAvatar.y + userAvatar.height
        //     visible: false

        //     MenuItem {
        //         text: "密码设置"
        //     }
        //     MenuItem {
        //         text: "退出登录"
        //     }
        // }

        // MouseArea {
        //     id: userAvatarMouseArea
        //     anchors.fill: userAvatar
        //     onClicked: {
        //         userMenu.visible =!userMenu.visible;
        //     }
        // }
    }

    // // 左侧菜单树布局
    // ColumnLayout {
    //     id: menuTreeLayout
    //     anchors.left: parent.left
    //     anchors.top: headerLayout.bottom
    //     anchors.bottom: parent.bottom
    //     width: 200

    //     // 可折叠抽屉组件
    //     Drawer {
    //         id: menuDrawer
    //         width: menuTreeLayout.width
    //         height: menuTreeLayout.height
    //         // opened: false
    //         // 菜单模型
    //         ListModel {
    //             id: menuModel

    //             ListElement {
    //                 name: "系统设置"
    //                 iconSource: "system_settings_icon.png"
    //                 attributes: [
    //                     ListElement {description: "用户列表功能"}, //, iconSource: "user_list_icon.png"
    //                     ListElement {description: "角色管理功能"} // , iconSource: "role_management_icon.png"
    //                 ]
    //             }

    //             ListElement {
    //                 name: "数据集管理"
    //                 iconSource: "dataset_management_icon.png"
    //                 attributes: [
    //                     ListElement {description: "数据列表"}, // , iconSource: "data_list_icon.png"
    //                     ListElement {description: "日志管理功能"} // , iconSource: "log_management_icon.png"
    //                 ]
    //             }
    //         }
    //         // 菜单委托，用于显示菜单树中的每个菜单项
    //         Component {
    //             id: menuDelegate

    //             Item {
    //                 id: menuItem
    //                 width: menuListView.width

    //                 // 菜单图标
    //                 Image {
    //                     id: menuIcon
    //                     source: model.iconSource
    //                     width: 20
    //                     height: 20
    //                     anchors.left: parent.left
    //                     anchors.verticalCenter: parent.verticalCenter
    //                 }

    //                 // 菜单名称
    //                 Text {
    //                     id: menuName
    //                     text: model.name
    //                     font.pointSize: 14
    //                     anchors.left: menuIcon.right
    //                     anchors.verticalCenter: parent.verticalCenter
    //                     anchors.leftMargin: 5
    //                 }

    //                 // 处理菜单收缩时只显示一级图标
    //                 visible:!(menuListView.currentIndex > 0 && menuListView.parentDrawer.open == false)

    //                 MouseArea {
    //                     id: menuItemMouseArea
    //                     anchors.fill: menuItem
    //                     onClicked: {
    //                         // 这里可添加点击菜单进入对应页面等逻辑
    //                     }
    //                 }
    //             }
    //         }
    //         // 菜单树列表视图
    //         ListView {
    //             id: menuListView
    //             width: menuDrawer.width
    //             height: menuDrawer.height
    //             model: menuModel
    //             delegate: menuDelegate
    //         }
    //     }

    //     // 用于展开/折叠抽屉的按钮
    //     Button {
    //         id: menuToggleButton
    //         text: "展开菜单"
    //         onClicked: {
    //             menuDrawer.open =!menuDrawer.open;
    //             if (menuDrawer.open) {
    //                 menuToggleButton.text = "收缩菜单";
    //             } else {
    //                 menuToggleButton.text = "展开菜单";
    //             }
    //         }
    //     }
    // }

    // // 中间页面内容布局
    // ColumnLayout {
    //     id: contentLayout
    //     anchors.top: headerLayout.bottom
    //     anchors.left: menuTreeLayout.right
    //     anchors.right: parent.right
    //     anchors.bottom: footLayout.top

    //     // 面包屑导航
    //     Text {
    //         id: breadcrumb
    //         text: "首页 > 当前页面"
    //         font.pointSize: 12
    //         Layout.alignment: Qt.AlignLeft | Qt.AlignTop
    //         Layout.topMargin: 10
    //         Layout.leftMargin: 10
    //     }
    //     // 页面卡片模型
    //     ListModel {
    //         id: pageCardModel

    //         ListElement {
    //             color: "lightblue"
    //             text: "页面卡片1内容"
    //         }

    //         ListElement {
    //             color: "lightgreen"
    //             text: "页面卡片2内容"
    //         }
    //     }
    //     // 页面卡片区域，这里简单示意，可根据实际情况扩展更多卡片及切换、关闭逻辑
    //     Repeater {
    //         id: pageCardsRepeater
    //         model: pageCardModel

    //         Rectangle {
    //             id: pageCard
    //             width: 200
    //             height: 150
    //             color: "lightblue"
    //             Text {
    //                 id: cardText
    //                 text: "页面卡片内容"
    //                 font.pointSize: 12
    //                 anchors.centerIn: parent
    //             }

    //             // 点击卡片切换逻辑，这里简单示例，可根据实际需求完善
    //             MouseArea {
    //                 id: cardMouseArea
    //                 anchors.fill: pageCard
    //                 onClicked: {
    //                     // 切换到当前点击的卡片，这里可添加更复杂的逻辑
    //                     pageCardsRepeater.currentIndex = index;
    //                 }
    //             }

    //             // 关闭卡片逻辑，这里简单示例，可根据实际需求完善
    //             Button {
    //                 id: closeCardButton
    //                 text: "×"
    //                 anchors.right: pageCard.right
    //                 anchors.top: pageCard.top
    //                 // anchors.margin: 5
    //                 visible: true

    //                 onClicked: {
    //                     // 隐藏当前卡片，这里可添加更复杂的逻辑
    //                     pageCard.visible = false;
    //                 }
    //             }
    //         }
    //     }
    // }

    // // 底部布局
    // RowLayout {
    //     id: footLayout
    //     anchors.bottom: parent.bottom
    //     anchors.left: parent.left
    //     anchors.right: parent.right
    //     height: 30

    //     Text {
    //         id: companyInfo
    //         text: "公司名称"
    //         font.pointSize: 12
    //         Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
    //         Layout.leftMargin: 10
    //     }
    //     Text {
    //         id: versionInfo
    //         text: "版本号：1.0"
    //         // font.pointization: 12
    //         Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
    //         Layout.rightMargin: 10
    //     }
    // }