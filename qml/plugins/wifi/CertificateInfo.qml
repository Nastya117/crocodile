import QtQuick 2.6
import QtQuick.Window 2.1

import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

import MeeGo.Connman 0.2

import Qt.labs.folderlistmodel 2.1

import "../../components"
import Certificates 1.0

Page {
    id: addCertificates

    property string name
    property bool certType

    headerTools: HeaderToolsLayout{
        id: header
        showBackButton: true
        title: qsTr("Certificate Info")
    }

    Column
    {
        visible: certType
        anchors.fill: parent
        spacing: Theme.itemSpacingSmall

        Label
        {
            text: "Name: " + name
        }

        Text
        {
            color: "white"
            text: "Path: " + cert.getPathByName(name, 0)
            width: parent.width
            font.pointSize: 30
            wrapMode: Text.Wrap
        }

        Button
        {
            text: "Delete"
            onClicked:
            {
                cert.removeCertificate(name, 0)
                pageStack.pop()
            }
        }
    }

    Column
    {
        visible: !certType
        anchors.fill: parent
        spacing: Theme.itemSpacingSmall

        Label
        {
            text: "Name: " + name
        }

        Text
        {
            color: "white"
            text: "Path to public key: " + cert.getPathByName(name, 1)
            width: parent.width
            font.pointSize: 30
            wrapMode: Text.Wrap
        }

        Text
        {
            color: "white"
            text: "Path to private key: " + cert.getPathByName(name, 2)
            width: parent.width
            font.pointSize: 30
            wrapMode: Text.Wrap
        }

        Button
        {
            text: "Delete"
            onClicked:
            {
                cert.removeCertificate(name, 1)
                cert.removeCertificate(name, 2)
                pageStack.pop()
            }
        }
    }
}
