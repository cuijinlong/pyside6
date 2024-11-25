import QtQuick

Item {
    property Component myComponent: redSquare

    QtObject {
        id: internalSettings
        property color color: "green"
    }

    Component {
        id: redSquare
        Rectangle {
            color: internalSettings.color
            width: 90
            height: 90
        }
    }

    Component.onCompleted: {
        console.log("ComponentTestMyItem Completed !")
    }
    Loader { sourceComponent: redSquare }
    // Loader { sourceComponent: redSquare; x: 100 }
}