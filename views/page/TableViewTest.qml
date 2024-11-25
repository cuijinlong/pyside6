import QtQuick
import QtQuick.Controls
import Qt.labs.qmlmodels

ApplicationWindow {
    width: 1000
    height: 600
    color: "#ffffff"
    visible: true
    Rectangle {
        id: rid
        // x: 900
        width: 50
        height: 50
        color: "red"
        opacity: 0.5
        border.width: 2
        // ...
    }
    TableView {
        // anchors.fill: parent
        // anchors.alignWhenCentered: true
        // anchors.horizontalCenter: parent.horizontalCenter
        // anchors.topMargin: 10
        anchors.left: rid.right
        anchors.leftMargin: 5
        id: tableView
        rowSpacing: 1
        columnSpacing: 1
        clip: true
        interactive: true
        boundsBehavior: Flickable.StopAtBounds
        width: 950
        height: 590
        // x: 100
        property var columnWidths: [50, 150, 150, 150, 150, 150, 150]
        columnWidthProvider: function (column) {
            return columnWidths[column]
        }
        Timer {
            running: true
            interval: 2000
            onTriggered: {
                // tableView.columnWidths[1] = 160
                // tableView.forceLayout();
            }
        }
        model: TableModel {
            id: tableModel
            onDataChanged: {
                console.log("数据发生变化了")
            }
            // TableModelColumn { 
            //     display: function(modelIndex) { 
            //         console.log("11111111111111-" + rows)
            //         // return rows[modelIndex.row][0].checked 
            //         return false
            //     }
            //     setDisplay: function(modelIndex, cellData) {
            //                     console.log("2222222222222-" + modelIndex)
            //                     model.rows[modelIndex.row][0].checked = cellData
            //                 }
            //  }
            TableModelColumn {display: "checked"}  
                            //    display: function(modelIndex) { 
                            //         return model.rows[modelIndex.row][0].checked 
                            //    }
                            //    setDisplay: function(modelIndex, cellData){
                            //                     console.log("2222222222222-")
                            //    }
                             
            TableModelColumn { display: "userName" }
            TableModelColumn { display: "realName" }
            TableModelColumn { display: "six" }
            TableModelColumn { display: "age" }
            TableModelColumn { display: "favior" }
            rows: [
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
                {"checked":true,"userName":"user1","realName":"用户1","six":"男","age":13,"favior":["篮球","足球"]},
                {"checked":true,"userName":"user1","realName":"用户1","six":"男","age":13,"favior":["篮球","足球"]}
            ]
            function copyToClipboard(params) {
                console.log(params)
            }

            function pasteFromClipboard(params) {
                console.log(params)
            }
        }
        
        Component.onCompleted: {
            // // Yes
            // tableModel.setRow(0,
            //                     {
            //                     checked: false,
            //                     userName: "user4",
            //                     realName: "用户4",
            //                     six: "男",
            //                     age: 20,
            //                     favior: ['乒乓球', '足球']
            //                     }
                
            //                  )
            // // Yes
            // model.appendRow({
            //                     checked: false,
            //                     userName: "user4",
            //                     realName: "用户4",
            //                     six: "男",
            //                     age: 20,
            //                     favior: ['乒乓球', '足球']
            //                 })

            //  // Yes           
            // model.insertRow(4, {
            //                     checked: false,
            //                     userName: "user5",
            //                     realName: "用户5",
            //                     six: "男",
            //                     age: 20,
            //                     favior: ['乒乓球', '足球']
            //                 })
            // // Yes
            // model.moveRow(0, model.rowCount - 3, 3)

            // // Yes
            // model.removeRow(0, 1)

            // // Yes    
            // model.setData(model.index(1, 1), 'display', 'sddd')
            
            // // Yes
            // for (var r = 0; r < model.rowCount; ++r) {
            //     console.log(model.data(model.index(r, 1), 'display'))
            //     console.log("username: " + model.data(model.index(r, 1), 'display') +
            //                 " realName " + model.getRow(r).realName)
            // }
        }
        delegate: DelegateChooser {
            DelegateChoice {
                column: 0
                delegate: CheckBox {
                    checked: model.display
                    implicitWidth: 10
                    onToggled: model.display = checked
                }
            }
            DelegateChoice {
                column: 1
                delegate: Text {
                    text: model.display
                }
            }
            DelegateChoice {
                column: 2
                delegate: Text {
                    text: model.display
                }
            }

            DelegateChoice {
                column: 3
                 delegate: Text {
                    text: model.display
                }
            }

            DelegateChoice {
                column: 4
                delegate: TextField {
                    text: model.display
                    selectByMouse: true
                    onAccepted: model.display = text
                }
            }

            DelegateChoice {
                column: 5
                delegate: Text {
                    text: model.display.join(',')
                }
                // delegate: TextField {
                //     text: model.display.join(',')
                //     selectByMouse: true
                //     onAccepted: model.display = text
                // }
            }
        }
        // selectionModel: ItemSelectionModel {
        //     onSelectionChanged: {
        //         // 当选择改变时，输出选中的项
        //         console.log("ItemSelectionModel.onSelectionChanged")
        //         // var selectedItems = [];
        //         // var currentIndex = tableView.selectionModel.currentIndex
        //         // var selectedIndexes = tableView.selectionModel.selectedIndexes
        //         // var selection = tableView.selectionModel.selection
        //         // // console.log("currentIndex " + tableModel.getRow(0, Qt.DisplayRole).userName)
        //         // var selectedData = [];
        //         // for (var i = 0; i < selectedIndexes.length; i++) {
        //         //     var data = model.getRow(selectedIndexes[i].row);
        //         //     selectedData.push(data.userName);
        //         // }
        //         // console.log("Selected items data:", selectedData.join(','));
        //         // for (var i = 0; i < sindex.length; i++) {
        //         //     var data = tableModel.data(sindex[i], Qt.DisplayRole);
        //         //     console.log("selectionModel.selectedIndexes" + data);
        //         // }
        //     }
        // }
        // delegate: Rectangle {
        //     implicitWidth: 100
        //     implicitHeight: 50
        //     color: selected ? "blue" : palette.base
        //     border.width: current ? 2 : 0
        //     required property bool selected
        //     required property bool current
        //     Text {
        //         text: model.display
        //         color: "#ffffff"
        //         anchors.centerIn: parent
        //     }
        //     TableView.editDelegate: TextField {
        //         anchors.fill: parent
        //         text: display
        //         horizontalAlignment: TextInput.AlignHCenter
        //         verticalAlignment: TextInput.AlignVCenter
        //         Component.onCompleted: selectAll()
        //         TableView.onCommit: {
        //             console.log("2223232322232332:{}3", text, current, selected)
        //             display = text
        //             // 'display = text' is short-hand for:
        //             let index = TableView.view.index(row, column)
        //             TableView.view.model.setData(index, text, Qt.DisplayRole)
        //         }
        //     }
        // }
        
        // Shortcut {
        //     sequence: StandardKey.Copy
        //     onActivated: {
        //         // let indexes = selectionModel.selectedIndexes
        //         // let rows = selectionModel.selection
        //         // tableView.model.copyToClipboard(rows)
        //     }
        // }

        // Shortcut {
        //     sequence: StandardKey.Paste
        //     onActivated: {
        //         // let currentIndex = selectionModel.currentIndex
        //         // console.log(currentIndex)
        //         // tableView.model.pasteFromClipboard(currentIndex)
        //     }
        // }
    }
}



// 如果我想要一个系统管理框架
// 左侧是支持抽屉的菜单树，树中有一个系统设置，它的下级是用户列表功能，角色管理功能，另外一个是数据集管理，它的下级是数据列表、日志管理功能，菜单名称的左侧带图标，菜单收缩就只显示一级图标
// 中间是每个菜单的页面内容，页面上面有面包屑和页面卡片，页面卡片之间支持自由切换和关闭，
// 头部的左侧是Logo和标题，右侧是用户头像和登录名称，点击头像出现下拉框，下拉菜单包括密码设置、退出登录
// 底部是公司和版本信息，我应该用什么布局来实现
