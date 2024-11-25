import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


Rectangle {
    id: menuId
    property alias leftMargin: contentLayout.anchors.leftMargin
    property alias menuTranslateX: menuTranslate.x
    property bool bMenuShown: true
    signal clicked(router: var, type: real)
    opacity: bMenuShown ? 1 : 0.5
    FontLoader { id: webFont; source: "../static/icons/iconfont.ttf" }
    // Text {
    //     text: "\uec6c"
    //     font.family: webFont.name
    // }
    Behavior on opacity {
        NumberAnimation {
            duration: 1000
        }
    }
    transform: Translate {
        id: menuTranslate
        x: 0
        Behavior on x {
            NumberAnimation {
                duration: 400;
                easing.type: Easing.OutQuad
            }
        }
    }
    ColumnLayout {
        id: contentLayout
        anchors.top: parent.top
        anchors.left: parent.left
        visible: true
        MenuItem {
            width: 200
            height: 50
            text: "菜单项1"
            contentItem: Text {
                text: parent.text
                color: "#000000" // 设置文本颜色
                font: parent.font
                elide: parent.elide
                verticalAlignment: Text.AlignVCenter
            }
            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 40
                color: hovered ? "#390d0d" : "transparent" // 鼠标悬停时的背景颜色
                border.color: "#13932f"
            }
            onTriggered: {
                menuId.clicked("菜单项1", 1)
                console.log("菜单项1")
            }
        }
        MenuItem {
            width: 200
            height: 50
            text: "菜单项2"
            contentItem: Text {
                text: parent.text
                color: "#000000" // 设置文本颜色
                font: parent.font
                elide: parent.elide
                verticalAlignment: Text.AlignVCenter
            }
            onTriggered: {
                menuId.clicked("菜单项2", 2)
                console.log("菜单项2")
            }
        }
    }
    // property alias menuLeftMargin: anchors.leftMargin
    // property alias menuAnchorsRight: anchors.right
    // property alias menuAnchorsLeft: anchors.left
    // property alias menuRight: anchors.right
    // property alias menuY: y
}
