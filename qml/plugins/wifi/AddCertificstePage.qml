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
    property int certType

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
            visible: certificateType
            id: pathText
            placeholderText: qsTr("Select file")
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    fileView.visible = true
                    certType = 0
                }
            }
        }


        TextField
        {
            id: pub
            visible: !certificateType
            placeholderText: qsTr("Path to public key")
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    fileView.visible = true
                    certType = 1
                }
            }
        }


        TextField
        {
            id: priv
            visible: !certificateType
            placeholderText: qsTr("Path to private key")
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    fileView.visible = true
                    certType = 2
                }
            }
        }


        Button{
            height: Theme.itemHeightSmall
            text: qsTr("Save")
            onClicked:
            {
                if (certificateType)
                    cert.addCertificate(nameText.text, pathText.text, 0)
                else
                {
                    cert.addCertificate(nameText.text, pub.text, 1)
                    cert.addCertificate(nameText.text, priv.text, 2)
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
                    if (certType == 0)
                        pathText.text = filePath
                    else
                        if (certType == 1)
                            pub.text = filePath
                        else
                            priv.text = filePath
                    fileView.visible = false
                }
            }
        }
    }
}
