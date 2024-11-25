import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    property var datasetRoutes:[{ "path": "/datasetTable", "name": "数据详情", "component": Qt.createComponent("DatasetTable.qml") },
                                { "path": "/datasetVariable", "name": "变量管理", "component": Qt.createComponent("DatasetVariable.qml") },
                                { "path": "/datasetLabel", "name": "标签管理", "component": Qt.createComponent("DatasetLabel.qml") }
                                ]
    TabBar {
        id: tabBarControl
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: 20
        height: 50
        Repeater {
            model: ["数据详情", "变量管理", "标签管理"]
            TabButton {
                id: tabButton
                anchors.top: parent.top
                width: 100
                height: 50
                Rectangle {
                    id: tabTitle
                    width: tabButton.width
                    height: tabButton.height - 2
                    Text {
                        anchors.centerIn: tabTitle
                        font.pointSize: 14
                        color: index == tabBarControl.currentIndex ? "#1a78ff" : "#484848"
                        text: modelData
                    }
                }
                Rectangle {
                    width: parent.width
                    height: 2
                    anchors.top: tabTitle.bottom
                    color: index == tabBarControl.currentIndex ? "#1a78ff" : "#ffffff"
                }
            }
        }
        onCurrentIndexChanged: {
            tabBarControl.currentIndex = currentIndex
            datasetPageLoader.sourceComponent = datasetRoutes[currentIndex].component
        }
    }
    Loader {
        id: datasetPageLoader
        anchors.left: tabBarControl.left
        anchors.top: tabBarControl.bottom
        anchors.right: parent.right
        width: parent.width
        height: parent.height - tabBarControl.height
        anchors.topMargin: 10
        sourceComponent: null
        Connections {
            target: datasetPageLoader.item
            ignoreUnknownSignals: true
            // 页面实现调整的
            function onSwitch(index) {
                console.log("onNavigate+++++++++++++++", index)
            }
        }
    }

    Component.onCompleted: {
        
    }
}