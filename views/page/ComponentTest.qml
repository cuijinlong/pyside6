import QtQuick

Rectangle {
    ListView {
        width: 100; height: 100
        model: 5
        delegate: myItem.mycomponent    //will create green Rectangles
        ComponentTestMyItem { id: myItem }
    }
    Component.onCompleted: {
        console.log("Nested Completed Running!")
    }
    Component.onDestruction: {
        console.log("Nested Destruction Beginning!")
    }
}
