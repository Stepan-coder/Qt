import QtQuick 2.13
import QtQuick.Window 2.13
import QtQuick.Controls 2.12
import AuthManager 1.0

Window
{
    id: window
    visible: true
    width: 300
    height: 500
    title: "Qt"
    property bool signInUp: true

    Loader
    {
        id: pageLoader
        anchors.fill: parent
        anchors.bottom: row.top
        source:(signInUp == true) ? "qrc:/LogInForm.qml" : "qrc:/RegistrationForm.qml"
    }

    Row
    {
        id: row
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        bottomPadding: 10
        spacing: 5

        ClickableText
        {
            id: signInText
            text: "Sign In"
            font.underline: signInUp
            onClicked:
            {
                signInUp = true
            }
        }

        Text
        {
            id: txtSlash
            color: "black"
            text: "/"
            font.pixelSize: 20
            visible: true
        }

        ClickableText
        {
            id: signUpText
            text: "Sign Up"
            font.underline: !signInUp
            onClicked:
            {
                signInUp = false
            }
        }
    }
}
