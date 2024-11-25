import QtQuick
import QtQuick.Controls
import "user" as User

Rectangle {
    width: 400
    height: 300
    color: "#ffffff"
    border.color: "#590909"
    border.width: 5
    radius: 15
    gradient: Gradient {
        orientation: Gradient.Horizontal
        GradientStop { position: 0.0; color: "lightsteelblue" }
        GradientStop { position: 1.0; color: "blue" }
    }

    Button {
        text: "获取当前登录人"
        onClicked: {
            let currentUser = loginController.getCurrentUser()
            if(currentUser) {
                console.log("获取当前登录人:" + currentUser.username);
            } else {
                console.log("未获取到当前登录人");
            }
        }
    }

    Button {
        text: "退出"
        onClicked: {
            loginController.logout()
        }
    }

    // ListModel { id: userVoList }

    // Component.onCompleted: {
    //     userVoList.clear()
    //     userVoList.append(userHandler.getUserList())
    //     // .forEach(function(item) {
    //     //     console.log(item.userName + item.six)
    //     //     userVoList.append({userName: item.userName, six: item.six})
    //     // })
    // }
    
    // ListView {
    //     id: clockview
    //     topMargin: 100
    //     anchors.fill: parent
    //     // orientation: ListView.Horizontal
    //     cacheBuffer: 2000
    //     snapMode: ListView.SnapOneItem
    //     highlightRangeMode: ListView.ApplyRange
    //     model: userVoList
    //     delegate: Rectangle {
    //         width: 200
    //         height: 30
    //         color: index % 2 ? "lightblue" : "lightgreen"
    //         Text {
    //             text: "userName:" + model.userName + "six:" + model.six
    //             anchors.centerIn: parent
    //         }
    //     }
    // }
    
    User.UserList {
    }
}

