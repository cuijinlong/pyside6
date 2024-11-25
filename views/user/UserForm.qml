import QtQuick
import QtQuick.Controls

Column {
    spacing: 10

    TextField {
        id: usernameInput
        placeholderText: "用户名"
    }

    TextField {
        id: emailInput
        placeholderText: "邮箱"
    }

    TextField {
        id: ageInput
        placeholderText: "年龄"
        inputMethodHints: Qt.ImhDigitsOnly
    }

    Button {
        text: "添加用户"
        onClicked: {
            userManager.addUser(usernameInput.text, emailInput.text, parseInt(ageInput.text))
            // Reset form
            usernameInput.text = ""
            emailInput.text = ""
            ageInput.text = ""
        }
    }
}
