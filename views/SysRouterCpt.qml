import QtQuick
import QtQuick.Controls

Item {
    id: router
    property var routes: []
    property string currentRoute: "/datasetIndex"
    width: root.width
    height: root.height - headerLayout.height - footLayout.height
    Loader {
        id: pageLoader
        anchors.fill: parent
        y: headerLayout.height
        sourceComponent: null
        Connections {
            target: pageLoader.item
            ignoreUnknownSignals: true
            // 页面实现调整的
            function onNavigate(path) {
                console.log("onNavigate+++++++++++++++")
            }
        }

    }

    function navigate(to) {
        currentRoute = to
        for (var i = 0; i < routes.length; i++) {
            if (routes[i].path === to) {
                console.error("routes[i]:", routes[i].path)
                pageLoader.sourceComponent = routes[i].component
                console.log("pageLoader.item", pageLoader.item)
                return
            }
        }
        console.error("No route found for:", to)
    }

    Component.onCompleted: {
        console.log('pageLoader:', pageLoader.width, pageLoader.height, root.width, root.height, headerLayout.width, headerLayout.height)
        routes = [
            { path: "/datasetIndex", name: "我的数据", component: Qt.createComponent("DatasetIndex.qml") },
            { path: "/dealIndex", name: "数据处理", component: Qt.createComponent("DealIndex.qml") },
            { path: "/analysisIndex", name: "数据分析", component:  Qt.createComponent("AnalysisIndex.qml") },
            { path: "/datavIndex", name: "数据可视化", component: Qt.createComponent("DatavIndex.qml") },
            { path: "/topicIndex", name: "专项分析", component: Qt.createComponent("TopicIndex.qml") },
            { path: "/datasetTable", name: "数据集列表", component: Qt.createComponent("DatasetTable.qml") },
            { path: "/datasetTab", name: "数据集列表", component: Qt.createComponent("DatasetTab.qml") },
        ]
        navigate(currentRoute)
    }

}