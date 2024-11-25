import QtQuick
import QtQuick.Controls

Item {
    id: datasetRoot
    property int activeIndex: -1
    property var mouseX: 0
    property var mouseY: 0
    ListModel { id: dataModel  }
    Component {
        id: cardDelegate
        Rectangle {
            id: cardRect
            property string bgColor: activeIndex == index ? "#f6f7f8" : "#ffffff"
            property var item: dataModel.get(index)
            width: 150
            height: 160 // 增加高度以容纳图片和文本
            color: bgColor
            Rectangle {
                id: imgRect
                width: 80
                height: 80 // 增加高度以容纳图片和文本
                color: bgColor
                anchors.horizontalCenter: cardRect.horizontalCenter
                anchors.topMargin: 50
                Image {
                    id: imgId
                    width: 40
                    height: 40
                    source: "../static/images/table.png"
                    anchors.centerIn: imgRect
                }
            }
            Text {
                text: item.title
                anchors.top: imgRect.bottom
                anchors.topMargin: 10
                width: 140
                color: "#2c3e50"
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            // 鼠标悬停高亮
            MouseArea {
                anchors.fill: parent
                anchors.topMargin: 10
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                hoverEnabled: true
                onClicked: {
                    router.navigate("/datasetTab")
                    // router.navigate("/datasetTable")
                }
                onEntered: {
                    activeIndex = index
                    menuRect.visible = true
                }
                onExited: {
                    activeIndex = -1
                    menuRect.visible = false
                }
            }
            Rectangle {
                id: menuRect
                width: 30
                height: 20
                color: bgColor
                anchors.right: cardRect.right
                anchors.rightMargin: 10
                y: 10
                visible: false
                Text {
                    text: "..."
                    color: "#2c3e50"
                    font.pointSize: 20
                    anchors.centerIn: menuRect
                }
                // 鼠标悬停高亮
                MouseArea {
                    anchors.fill: parent
                    // hoverEnabled: true
                    // focus: true
                    // propagateComposedEvents: true
                    // preventStealing: true
                    // pressAndHoldInterval: 1200
                    onClicked: (mouse)=> {
                        var item = gridView.itemAtIndex(index)
                        optMenu.x = item.x + 140
                        optMenu.y = item.y - 10
                        optMenu.visible = true
                    }
                    onEntered: {
                        // var item = gridView.itemAtIndex(index)
                        // optMenu.x = item.x
                        // optMenu.y = item.y
                        // optMenu.visible = true
                    }
                    onExited: (mouse) => {
                        console.log("menuRect:onExited")
                        // optMenu.visible = false
                    }
                }
            }
            required property int index
        }
    }
    Rectangle {
        anchors.fill: parent
        anchors.topMargin: 20
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        // 使用ListView显示卡片
        GridView {
            id: gridView
            anchors.fill: parent
            cellWidth: 151
            cellHeight: 161
            clip: true
            model: dataModel
            delegate: cardDelegate
            displayMarginBeginning : 35
            displayMarginEnd : 35
        }
        // 鼠标悬停高亮
        // MouseArea {
        //     anchors.fill: parent
        //     // 但它没有设置 hoverEnabled 属性，那么鼠标事件可以穿透 MouseArea 到达下面的元素
        //     // hoverEnabled: true
        //     propagateComposedEvents: true
        //     onPositionChanged: (mouse) => {
        //         datasetRoot.mouseX = mouse.x
        //         datasetRoot.mouseY = mouse.y
        //         // console.log("menuRect:onExitedmenuRect:onExitedmenuRect:onExitedmenuRect:onExitedmenuRect:onExitedmenuRect:onExited")
        //         console.log(datasetRoot.mouseX, datasetRoot.mouseY)
        //         mouse.accepted = true
        //     }
        // }
        Menu {
            id: optMenu
            // Action { text: qsTr("复制"); checkable: false; checked: false }
            Action { text: qsTr("数据处理"); onTriggered: { console.log(menuItem.text) }}
            Action { text: qsTr("数据分析"); onTriggered: { console.log(menuItem.text) }}
            Action { text: qsTr("数据可视化"); onTriggered: { console.log(menuItem.text) }}
            MenuSeparator {contentItem: Rectangle {implicitWidth: 150; implicitHeight: 1; color: "#e1e1e1"} }
            Action { text: qsTr("编辑"); onTriggered: { console.log(menuItem.text) }}
            Action { text: qsTr("复制"); onTriggered: { console.log(menuItem.text) }}
            Action { text: qsTr("删除"); onTriggered: { console.log(menuItem.text) }}
            // Menu {
            //     title: qsTr("Advanced")
            //     // ...
            // }
            visible: false
            delegate: MenuItem {
                id: menuItem
                implicitWidth: 200
                implicitHeight: 40
                contentItem: Text {
                    leftPadding: menuItem.indicator.width
                    rightPadding: menuItem.arrow.width
                    text: menuItem.text
                    font: menuItem.font
                    opacity: enabled ? 1.0 : 0.3
                    color: menuItem.highlighted ? "#4e4e4e" : "#4e4e4e"
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }
                background: Rectangle {
                    implicitWidth: 200
                    implicitHeight: 40
                    opacity: enabled ? 1 : 0.3
                    color: menuItem.highlighted ? "#f5f7fa" : "transparent"
                }
                onClicked: {
                    console.log(menuItem.text, menuItem.action)
                }
            }
            background: Rectangle {
                implicitWidth: 200
                implicitHeight: 40
                color: "#ffffff"
                border.color: "#f5f7fa"
                radius: 2
            }
        }
    }
    Component.onCompleted: {
        var data = [{id: 1, title: "spikes", value: "7mm"}, {id: 1, title:"color", value: "green"}]
        dataModel.append(data);
    }
    
}