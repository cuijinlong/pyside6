import QtQuick
import QtQuick.Controls

Rectangle {
    id: analysisIndex
    signal navigate(path: var)
    width: 400
    height: 300
    color: "#590909"
    Text {
        text: "数据分析"
    }
    Button {
        id: btnSignal
        text: "触发页面跳转"
        onClicked: {
            // console.log("btnSignal")
            navigate("/datasetTable")
        }
    }
}