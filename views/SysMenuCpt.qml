import QtQuick
import QtQuick.Controls

Rectangle {
    id: menuRoot
    property int activeIndex: 0
    signal clicked(router: var, type: real)
    Row {
        Repeater {
            id: repeater
            model: [
                        { path: "/datasetIndex", name: "我的数据", component: Qt.createComponent("DatasetIndex.qml") },
                        { path: "/dealIndex", name: "数据处理", component: Qt.createComponent("DealIndex.qml") },
                        { path: "/analysisIndex", name: "数据分析", component:  Qt.createComponent("AnalysisIndex.qml") },
                        { path: "/datavIndex", name: "数据可视化", component: Qt.createComponent("DatavIndex.qml") },
                        { path: "/topicIndex", name: "专项分析", component: Qt.createComponent("TopicIndex.qml") },
                    ]
            delegate: MenuItem {
                required property var model
                id: menuItem
                text: model.name
                width: 120
                height: 50
                contentItem: Text {
                    id: menuItemText
                    text: model.name
                    opacity: 1.0
                    font.pointSize: 15
                    states: [
                        State { name: "default"; PropertyChanges { target: menuItemText; color: "#181818" } },
                        State { name: "clicked"; PropertyChanges { target: menuItemText; color: "#17a81a" } }
                    ]
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }
                background: Rectangle {
                    id: bgColor
                    height: 2
                    opacity: 0.68
                    y:47
                    border.width: 0
                    color: "#f6f7f8"
                    states: [
                        State { name: "default"; PropertyChanges { target: bgColor; color: "#f6f7f8" } },
                        State { name: "clicked"; PropertyChanges { target: bgColor; color: "#17a81a" } }
                    ]
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        menuRoot.activeIndex = index
                        menuRoot.updateStates()
                        menuRoot.clicked(model.path, 1)
                    }
                }
                required property int index
            }
        }
        Component.onCompleted: {
            var delegate = repeater.itemAt(0)
            menuRoot.clicked(delegate.model.path, 1)
            delegate.background.state = "clicked"
            delegate.contentItem.state = "clicked"

        }
    }
    function updateStates() {
        for (var i = 0; i < repeater.count; i++) {
            var delegate = repeater.itemAt(i)
            if (i === activeIndex) {
                delegate.background.state = "clicked"
                delegate.contentItem.state = "clicked"
            } else {
                delegate.background.state = "default"
                delegate.contentItem.state = "default"
            }
        }
    }
}


// Rectangle {
//     anchors.fill: parent
//     height: 100
//     Button {
//         id: myDataBtn
//         text: qsTr("我的数据")
//         width: 100
//         height: 50
//         anchors.top: parent.top
//         anchors.left: parent.left
//         contentItem: Text {
//             text: myDataBtn.text
//             font: myDataBtn.font
//             opacity: enabled ? 1.0 : 0.3
//             color: myDataBtn.down ? "#17a81a" : "#21be2b"
//             horizontalAlignment: Text.AlignHCenter
//             verticalAlignment: Text.AlignVCenter
//             elide: Text.ElideRight
//         }
//         background: Rectangle {
//             implicitWidth: 100
//             implicitHeight: 40
//             opacity: enabled ? 1 : 0.3
//             border.color: myDataBtn.down ? "#17a81a" : "#21be2b"
//             border.width: 1
//             radius: 2
//         }
//     }

//     Button {
//         id: dataDealBtn
//         width: 100
//         height: 50
//         anchors.top: parent.top
//         anchors.left: myDataBtn.right
//         text: qsTr("数据处理")
//         contentItem: Text {
//             text: dataDealBtn.text
//             font: dataDealBtn.font
//             opacity: enabled ? 1.0 : 0.3
//             color: dataDealBtn.down ? "#17a81a" : "#21be2b"
//             horizontalAlignment: Text.AlignHCenter
//             verticalAlignment: Text.AlignVCenter
//             elide: Text.ElideRight
//         }
//         background: Rectangle {
//             implicitWidth: 100
//             implicitHeight: 50
//             opacity: enabled ? 1 : 0.3
//             border.color: dataDealBtn.down ? "#17a81a" : "#21be2b"
//             border.width: 1
//             radius: 2
//         }
//     }
// }
// Rectangle {
//     anchors.fill: parent
//     height: 100
//     ListModel {
//         id: menuModel
//         ListElement {
//             menuId: "wdsj"
//             menuName: "我的数据"
//             menuPath: "../static/a.qml"
//             enabled: true
//             down: false
//         }
//         ListElement {
//             menuId: "sjcl"
//             menuName: "数据处理"
//             menuPath: "../static/b.qml"
//             enabled: true
//             down: false
//         }
//         ListElement {
//             menuId: "sjfx"
//             menuName: "数据分析"
//             menuPath: "../static/c.qml"
//             enabled: true
//             down: false
//         }
//     }
//     ListView {
//         id: menuListView
//         width: 500
//         height: 50
//         model: menuModel
//         visible: true
//         orientation: ListView.Horizontal
//         layoutDirection: Qt.LeftToRight
//         highlight: highlight
//         focus: false
//         currentIndex: 0
//         highlightMoveVelocity: -1
//         delegate: ItemDelegate {
//             id: itemDelegate
//             text: qsTr(menuName)
//             contentItem: Text {
//                 rightPadding: 1
//                 text: qsTr(menuName)
//                 states: [
//                     State {
//                         name: "default"
//                         PropertyChanges { target: itemDelegate; color: "#dddedf" }
//                     },
//                     State {
//                         name: "clicked"
//                         PropertyChanges { target: itemDelegate; color: "#17a81a" }
//                     }
//                 ]
//                 // color: index == currentIndex ? "#21be2b" : "#bdbebf"
//                 elide: Text.ElideRight
//                 verticalAlignment: Text.AlignVCenter
//             }
//             MouseArea {
//                 anchors.fill: parent
//                 onClicked: {
//                     // console.log("onClick:currentIndex:" + index)
//                     // menuListView.currentIndex = index
//                     // itemDelegate.state = "clicked"
//                     itemDelegate.state == 'clicked' ? itemDelegate.state = "default" : itemDelegate.state = 'clicked';
//                 }
//             }
//             // background: Rectangle {
//             //     implicitWidth: 100
//             //     implicitHeight: 40
//             //     opacity: enabled ? 1 : 0.3
//             //     // 状态和转换
//             //     // states: [
//             //     //     State {
//             //     //         name: "default"
//             //     //         PropertyChanges { target: itemDelegate; color: "#dddedf" }
//             //     //     },
//             //     //     State {
//             //     //         name: "clicked"
//             //     //         PropertyChanges { target: itemDelegate; color: "#17a81a" }
//             //     //     }
//             //     // ]
//             //     // color: index == currentIndex ? "#dddedf" : "#eeeeee"
//             //     Rectangle {
//             //         width: parent.width
//             //         height: 1
//             //         // 状态和转换
//             //         // states: [
//             //         //     State {
//             //         //         name: "default"
//             //         //         PropertyChanges { target: itemDelegate; color: "#dddedf" }
//             //         //     },
//             //         //     State {
//             //         //         name: "clicked"
//             //         //         PropertyChanges { target: itemDelegate; color: "#17a81a" }
//             //         //     }
//             //         // ]
//             //         // color: index == currentIndex ?"#17a81a" : "#eeeeee"
//             //         anchors.bottom: parent.bottom
//             //     }
//             // }
//         }
//     }
// }

// // Timer {
// //     id: timer
// //     interval: 2000; repeat: true
// //     running: true
// //     triggeredOnStart: true

// //     onTriggered: {
// //         var msg = {'action': 'appendCurrentTime', 'model': listModel};
// //         worker.sendMessage(msg);
// //     }
// // }