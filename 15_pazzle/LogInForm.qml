import QtQuick 2.0
import QtQuick.Window 2.13
import QtQuick.Controls 2.12

Item
{
    id: logining
    Column
    {
        id: logInColumn
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 10
        spacing: 10

        Text
        {
            id: logIntitle
            text: "SIGN IN"
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 30
            color: "black"
        }

        TextField
        {
            id: singInLogin
            width: Window.width - 30
            anchors.horizontalCenter: parent.horizontalCenter
            placeholderText: "login..."
            font.pixelSize: 20
        }

        TextField
        {
            id: singInPassword
            width: Window.width - 30
            anchors.horizontalCenter: parent.horizontalCenter
            placeholderText: "password..."
            echoMode: TextInput.Password
            font.pixelSize: 20
        }

        Button
        {
            id: singInButton
            text: "Sign In"
            anchors.horizontalCenter: parent.horizontalCenter
            enabled: (signInUp && singInLogin.length > 5 && singInPassword.length > 5)
            onClicked: singInLoading.visible = true
        }

        BusyIndicator
        {
            id: singInLoading
            anchors.horizontalCenter: parent.horizontalCenter
            visible: false
        }
    }
}
