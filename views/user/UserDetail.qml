import QtQuick
import QtQuick.Controls

Column {
    id: userDetail
    visible: false

    Text {
        text: "用户详情"
    }

    Text {
        text: "ID: " + userDetailModel.id
    }

    Text {
        text: "用户名: " + userDetailModel.username
    }

    Text {
        text: "邮箱: " + userDetailModel.email
    }

    Text {
        text: "年龄: " + userDetailModel.age
    }
}
