import QtQuick
import QtQuick.Controls
import "content" as Content

Rectangle {
    width: 380; height: 130
    ListModel { id: userVoList }
    // ListModel {
    //     ListElement { cityName: "New York"; timeShift: -4 }
    //     ListElement { cityName: "London"; timeShift: 0 }
    //     ListElement { cityName: "Oslo"; timeShift: 1 }
    //     ListElement { cityName: "Mumbai"; timeShift: 5.5 }
    //     ListElement { cityName: "Tokyo"; timeShift: 9 }
    //     ListElement { cityName: "Brisbane"; timeShift: 10 }
    //     ListElement { cityName: "Los Angeles"; timeShift: -8 }
    // }
    Component.onCompleted: {
        userVoList.clear()
        userVoList.append(userHandler.getUserList())
        // .forEach(function(item) {
        //     console.log(item.userName + item.six)
        //     userVoList.append({userName: item.userName, six: item.six})
        // })
    }

    TableView {
        id: tableView
        //topMargin: 100
        //anchors.left: parent.left
        //anchors.right: parent.right
        //anchors.top: parent.top
        //anchors.bottom: addUserForm.top
        //anchors.margins: 10
        //cellWidth: width / 3
        //cellHeight: 40
        //orientation: ListView.Horizontal
        //cacheBuffer: 2000
        //snapMode: ListView.SnapOneItem
        //highlightRangeMode: ListView.ApplyRange
        anchors.fill: parent
        anchors.margins: 10
        model: userVoList
        columns: [
            // 定义列
            TableViewColumn {
                role: "userName"
                title: "姓名"
                width: 200
            },
            TableViewColumn {
                role: "six"
                title: "性别"
                width: 100
            },
            TableViewColumn {
                role: "age"
                title: "年龄"
                width: 100
            }
        ]
    }
}