import QtQuick 2.0
import QtQuick.Window 2.13
import QtQuick.Controls 2.12

Item
{
    id: registration
    Column
    {
        id: singUpColumn
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 10
        spacing: 10

        Text
        {
            id: singUpTitle
            text: "SIGN UP"
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 30
            color: "black"
        }

        TextField
        {
            id: singUpLogin
            width: Window.width - 30
            placeholderText: "login..."
            font.pixelSize: 20
        }

        TextField
        {
            id: singUpPassword
            width: Window.width - 30
            placeholderText: "password..."
            echoMode: "Password"
            font.pixelSize: 20
        }

        TextField
        {
            id: singUpRepeat
            width: Window.width - 30
            placeholderText: "repeat password..."
            echoMode: "Password"
            font.pixelSize: 20
        }

        TextField
        {
            id: singUpNick
            width: Window.width - 30
            placeholderText: "nickname..."
            font.pixelSize: 20
        }

        BusyIndicator
        {
            id: singUpLoading
            anchors.horizontalCenter: parent.horizontalCenter
            visible: false
        }

        Text
        {
            id: singUpPasswordError
            text: "Password value aren't same!"
            color: "red"
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 20
            visible: false
        }

        Button
        {
            id: singUpButton
            text: "Sign Up"
            enabled: (!signInUp && singUpLogin.length > 5 && singUpPassword.length > 5
                      && singUpRepeat.length > 5 && singUpNick.length > 5)
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked:
            {
                if ((singUpPassword.text != singUpRepeat.text) && !signInUp)
                    singUpPasswordError.visible = true
                else
                {
                    singUpLoading.visible = true
                    singUpPasswordError.visible = false
                }
            }
        }
    }

    function cleanUp()
    {
        signInUp = false
        singUpLogin.text = ''
        singUpPassword.text = ''
        singUpRepeat.text = ''
        singUpNick.text = ""
        singUpLoading.visible = false
    }

}
