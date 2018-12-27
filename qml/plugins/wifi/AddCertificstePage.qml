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

    property bool certificateType

    headerTools: HeaderToolsLayout{
        id: header
        showBackButton: true
        title: qsTr("Add Certificate")
    }


    Column
    {
        visible: !fileView.visible
        anchors.fill: parent
        spacing: Theme.itemSpacingSmall


        TextField
        {
            id: nameText
            placeholderText: qsTr("Name")
        }

        TextField
        {
            id: pathText
            placeholderText: qsTr("Select file")
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    fileView.visible = true
                }
            }
        }


        TextField
        {
            visible: !certificateType
            placeholderText: qsTr("Path to public key")
        }


        TextField
        {
            visible: !certificateType
            placeholderText: qsTr("Path to private key")
        }


        TextField
        {
            visible: !certificateType
            placeholderText: qsTr("Passphrase")
        }


        Button{
            height: Theme.itemHeightSmall
            text: qsTr("Save")
            onClicked:
            {
                if (certificateType)
                {
                    cert.addCertificate(nameText.text, pathText.text, 0)
                }
                pageStack.pop()
            }
        }
    }



    FolderListModel {
        id: folderModel
    }



    ListView{
        property string prevPath
        id: fileView
        visible: false
        anchors.fill: parent

        model: folderModel
        delegate:
            ListViewItemWithActions{
            label: fileName
            onClicked:
            {
                if (fileIsDir)
                    folderModel.folder = filePath
                else
                {
                    pathText.text = filePath
                    fileView.visible = false
                }
            }
        }
    }
}
