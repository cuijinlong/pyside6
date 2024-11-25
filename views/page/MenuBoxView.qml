import QtQuick
import QtQuick.Controls

Rectangle {
    width: 996
    height: 649
    color: "#1b1818"
    MenuBar {
        id: menuBar
        Menu {
            id: menuOne
            title: "文件(&F)"
            MenuItem {
                text: "新建"
                onTriggered: {
                    // 在这里处理新建操作
                    console.log("新建文件")
                    menuHandler.openFile()
                }
            }
            MenuItem {
                text: "打开"
                onTriggered: {
                    // 在这里处理打开操作
                    console.log("打开文件")
                }
            }
            MenuItem {
                text: "保存"
                onTriggered: {
                    // 在这里处理保存操作
                    console.log("保存文件")
                }
            }
            MenuItem {
                text: "退出"
                onTriggered: {
                    console.log("退出")
                }
            }
        }
        Menu {
            id: menuTwo
            title: "编辑(&E)"
            MenuItem {
                text: "撤销"
                onTriggered: {
                    // 在这里处理撤销操作
                    console.log("撤销操作")
                }
            }
            MenuItem {
                text: "重做"
                onTriggered: {
                    // 在这里处理重做操作
                    console.log("重做操作")
                }
            }
        }
    }

    // Column {
    //     Button {
    //         text: "获取当前登录人"
    //         onClicked: {
    //             let currentUser = loginController.getCurrentUser()
    //             if(currentUser) {
    //                 console.log("获取当前登录人:" + currentUser.username);
    //             } else {
    //                 console.log("未获取到当前登录人");
    //             }
    //         }
    //     }
    //     Button {
    //         text: "退出"
    //         onClicked: {
    //             loginController.logout()
    //         }
    //     }
    // }
}



// ApplicationWindow {
//     width: 1400
//     height: 1300
//     color: "#1b1818"

//     // Text {
//     //     text: "首页"
//     // }
    
//     Column {
//         Button {
//             text: "获取当前登录人"
//             onClicked: {
//                 let currentUser = loginController.getCurrentUser()
//                 if(currentUser) {
//                     console.log("获取当前登录人:" + currentUser.username);
//                 } else {
//                     console.log("未获取到当前登录人");
//                 }
//             }
//         }

//         Button {
//             text: "退出"
//             onClicked: {
//                 loginController.logout()
//             }
//         }
//     }
// }
