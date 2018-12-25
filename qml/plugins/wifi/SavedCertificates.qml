import QtQuick 2.6
import QtQuick.Window 2.1

import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

import MeeGo.Connman 0.2

import "../../components"

import Certificates 1.0

Page {


    headerTools: HeaderToolsLayout {
        id: header
        showBackButton: true;
        title: qsTr("Manage saved certificates")
    }


    Component.onCompleted:
    {
        cert.getCertList()
    }






    Flickable{
        width: parent.width
        height: parent.height-header.height
        contentHeight: certificatesColumn.height+size.dp(50)

        clip: true
        anchors{
            top: header.bottom + size.dp(20)
            topMargin: size.dp(80)
            left: parent.left
            leftMargin: size.dp(20)
        }

        Column{
            id: certificatesColumn
            spacing: Theme.itemSpacingSmall
            width: parent.width

            Text{
                text: qsTr("ca certificates")
                color: Theme.textColor
                font.pointSize: Theme.fontSizeSmall
            }

            Rectangle{
                width: parent.width
                height: 1
            }


            Repeater{
                width: parent.width
                model: cert.certList
                delegate: ListViewItemWithActions{
                    label: modelData
                }
            }


            ListViewItemWithActions{
                label: qsTr("Add")
                onClicked:
                {
                    pageStack.push(Qt.resolvedUrl("AddCertificstePage.qml"),{certificateType: true})
                }

            }


            Text{
                text: qsTr("client key")
                color: Theme.textColor
                font.pointSize: Theme.fontSizeSmall
            }

            Rectangle{
                width: parent.width
                height: 1
            }

            Repeater{
                width: parent.width
                model: 3
                delegate: ListViewItemWithActions{
                    label: qsTr("certificate ") + modelData
                }
            }

            ListViewItemWithActions{
                label: qsTr("Add")
                onClicked:
                {
                    pageStack.push(Qt.resolvedUrl("AddCertificstePage.qml"),{certificateType: false})
                }

            }
        }
    }
}
