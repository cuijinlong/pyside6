import QtQuick
import QtQuick.Controls

Rectangle {
    width: 400
    height: 300
    color: "#ffffff"
    // 其他 QML 控件，例如文本、按钮等
    // Text {
    //     id: statusText
    //     text: "未登录"
    //     anchors.centerIn: parent
    // }
    Column {
        spacing: 10
        anchors.centerIn: parent

        TextField {
            id: usernameField
            placeholderText: "Username"
        }

        TextField {
            id: passwordField
            placeholderText: "Password"
            echoMode: TextInput.Password
        }

        Button {
            text: "登录"
            onClicked: {
                var success = loginController.login(usernameField.text, passwordField.text)
                if (success) {
                    console.log("Login successful");
                } else {
                    console.log("Login failed");
                }
            }
        }
    }
}
