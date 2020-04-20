import QtQuick 2.0
import QtQuick.Window 2.13
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.1
import AuthManager 1.0

Item
{
    id: registration
    AuthManager
    {
        id: registerManager
        onRegisterFinished:
        {
            isRegProcessing = false;
            r_reg.visible = true
            r_reg.title = "Reg finished!"
            r_reg.text = "РЕГИСТРАЦИЯ ЗАВЕРШЕНА!"
        }
        onRegisterFailed:
        {
            isRegProcessing = false;
            r_reg.visible = true
            r_reg.title = "Reg failed!"
            r_reg.text = "ВОЗНИКЛА ОШИБКА: " + error
        }
    }

    MessageDialog
    {
        id: r_reg
        title: ""
        text: ""
    }

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
            echoMode: TextInput.Password
            font.pixelSize: 20
        }

        TextField
        {
            id: singUpRepeat
            width: Window.width - 30
            placeholderText: "Please,repeat password..."
            echoMode: TextInput.Password
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
            enabled: (singUpLogin.length > 5 && singUpPassword.length > 5
                      && singUpRepeat.length > 5 && singUpNick.length > 5)
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked:
            {
                if (singUpPassword.text != singUpRepeat.text)
                    singUpPasswordError.visible = true
                else
                {
                    singUpLoading.visible = true
                    singUpPasswordError.visible = false
                }
                registerManager.reg(singUpLogin.text, singUpPassword.text)
                clearFields();
            }
        }
    }

    function clearFields()
    {
        singUpLogin.clear();
        singUpPassword.clear();
        singUpRepeat.clear();
        singUpNick.clear();
    }
}
