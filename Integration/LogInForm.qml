import QtQuick 2.0
import QtQuick.Window 2.13
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.1
import AuthManager 1.0

Item
{
    id: logining
    AuthManager
    {
        id: authManager
        onAuthFinished:
        {
//            console.log("Auth finished!");
//            console.log(token);
            m_auth.visible = true
            m_auth.title = "Auth finished!"
            m_auth.text = token
        }
        onAuthFailed:
        {
//            console.log("Auth failed!");
//            console.log(error);
            m_auth.visible = true
            m_auth.title = "Auth failed!"
            m_auth.text = error
        }
    }

    MessageDialog
    {
        id: m_auth
        title: ""
        text: ""
    }

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
            enabled: (singInLogin.length > 5 && singInPassword.length > 5)
            onClicked:
            {
                singInLoading.visible = true
                authManager.auth(singInLogin.text, singInPassword.text)
                clearFields();
            }
        }

        BusyIndicator
        {
            id: singInLoading
            anchors.horizontalCenter: parent.horizontalCenter
            running: false
        }
    }

    function clearFields()
    {
        singInLogin.clear();
        singInPassword.clear();
    }
}
