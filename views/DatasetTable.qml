import QtQuick
import QtQuick.Controls
import Qt.labs.qmlmodels

Rectangle {
    id: datasetTableRoot
    anchors.fill: parent
    ListModel { id: headModel  }
    property var listData: [{"checked":true,"userName":"user1","realName":"用户1","six":"男","age":13,"favior":["篮球","足球"]},
                            {"checked":true,"userName":"user1","realName":"用户1","six":"男","age":13,"favior":["篮球","足球"]},
                            {"checked":true,"userName":"user1","realName":"用户1","six":"男","age":13,"favior":["篮球","足球"]},
                            {"checked":true,"userName":"user1","realName":"用户1","six":"男","age":13,"favior":["篮球","足球"]},
                            {"checked":true,"userName":"user1","realName":"用户1","six":"男","age":13,"favior":["篮球","足球"]},
                            {"checked":true,"userName":"user1","realName":"用户1","six":"男","age":13,"favior":["篮球","足球"]},
                            {"checked":true,"userName":"user1","realName":"用户1","six":"男","age":13,"favior":["篮球","足球"]},
                            {"checked":true,"userName":"user1","realName":"用户1","six":"男","age":13,"favior":["篮球","足球"]},
                            {"checked":true,"userName":"user1","realName":"用户1","six":"男","age":13,"favior":["篮球","足球"]},
                            {"checked":true,"userName":"user1","realName":"用户1","six":"男","age":13,"favior":["篮球","足球"]},
                            {"checked":true,"userName":"user1","realName":"用户1","six":"男","age":13,"favior":["篮球","足球"]},
                            {"checked":true,"userName":"user1","realName":"用户1","six":"男","age":13,"favior":["篮球","足球"]},
                            {"checked":true,"userName":"user1","realName":"用户1","six":"男","age":13,"favior":["篮球","足球"]},
                            {"checked":true,"userName":"user1","realName":"用户1","six":"男","age":13,"favior":["篮球","足球"]},
                            {"checked":true,"userName":"user1","realName":"用户1","six":"男","age":13,"favior":["篮球","足球"]},
                            {"checked":true,"userName":"user1","realName":"用户1","six":"男","age":13,"favior":["篮球","足球"]},
                            {"checked":true,"userName":"user1","realName":"用户1","six":"男","age":13,"favior":["篮球","足球"]},
                            {"checked":true,"userName":"user1","realName":"用户1","six":"男","age":13,"favior":["篮球","足球"]},
                            {"checked":true,"userName":"user1","realName":"用户1","six":"男","age":13,"favior":["篮球","足球"]},
                            {"checked":true,"userName":"user1","realName":"用户1","six":"男","age":13,"favior":["篮球","足球"]},
                            {"checked":true,"userName":"user1","realName":"用户1","six":"男","age":13,"favior":["篮球","足球"]}
                        ]
    property var enHead: ["", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
    
    Rectangle {
        id: allRect
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: horizontalHeader.left
        anchors.bottom: verticalHeader.top
        color: "#dde5ed"
    }

    HorizontalHeaderView {
        id: horizontalHeader
        anchors.left: tableView.left
        anchors.top: parent.top
        syncView: tableView
        height: 55
        clip: true
        model: headModel
        delegate: Column {
                    Rectangle {
                                id: enHeader
                                width: model.width
                                height: 20
                                color: "#dde5ed"
                                Text {
                                    anchors.centerIn: parent
                                    font.pointSize: 12
                                    color: "#2b323d"
                                    text: enHead[model.num]
                                }
                            }
                    Rectangle {
                                id: chHeader
                                anchors.top: enHeader.bottom
                                width: model.width
                                height: 35
                                color: "#ffffff"
                                border.color: "#f6f6f6"
                                Text {
                                    anchors.centerIn: parent
                                    font.pointSize: 12
                                    color: "#2b323d"
                                    text: model.title 
                                }
                            }
        }
    }

    VerticalHeaderView {
        id: verticalHeader
        anchors.top: tableView.top
        anchors.left: parent.left
        syncView: tableView
        clip: true
        model: listData
        delegate: Rectangle {
            width: verticalHeader.width
            height: verticalHeader.height
            color: "#dde5ed"
            border.color: "#f6f6f6"
            Text {
                anchors.centerIn: parent
                font.pointSize: 12
                color: "#2b323d"
                text: index + 1
            }
        }
    }
    
    TableView {
        id: tableView
        anchors.left: verticalHeader.right
        anchors.top: horizontalHeader.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        clip: true
        // columnSpacing: 1
        // rowSpacing: 1
        columnWidthProvider: function (column) {
            return headModel.get(column).width
        }

        model: TableModel {
            TableModelColumn { display: "userName" }
            TableModelColumn { display: "realName" }
            TableModelColumn { display: "six" }
            TableModelColumn { display: "age" }
            rows: listData
        }

        selectionModel: ItemSelectionModel { }

        delegate: Rectangle {
            required property bool selected
            required property bool current
            implicitHeight : 35 // 行高
            height : 35 // 行高
            border.width: current ? 2 : 1
            border.color: current ? "#1a78ff" : "#f6f6f6"
            Text {
                text: display
                font.pointSize: 12
                anchors.centerIn: parent
                color: "#2b323d"
                // padding: 12
            }
        }
    }
    Component.onCompleted: {
        var headData = [
                        {num: 1, title: "账号", width: 100},
                        {num: 2, title: "真实姓名", width: 80},
                        {num: 3, title: "性别", width: 70},
                        {num: 4, title: "年龄", width: 100},
                       ]
        headModel.append(headData);
    }
}
    
    