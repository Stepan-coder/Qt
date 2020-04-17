import QtQuick 2.0
import QtQuick.Window 2.13
import QtQuick.Controls 2.12

Text
{
    id: clickableText
    text: "some Text"
    color: "black"
    font.pixelSize: 18
    font.bold: true
    font.underline: true
    visible: true
    signal clicked()
    MouseArea
    {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked:
        {
            clickableText.clicked()
        }
    }
}
