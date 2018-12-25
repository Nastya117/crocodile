import QtQuick 2.6
import QtQuick.Window 2.1

import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

import MeeGo.Connman 0.2

import "../../components"

Page {
    id: savedPage
    headerTools: HeaderToolsLayout{
        id: header
        showBackButton: true
        title: qsTr("Add Network")
    }


    ListModel {
        id: secureModel
        ListElement { name: "None";}
        ListElement { name: "802.1x EAP";}
        ListElement { name: "WPA/WPA2 PSK";}
    }

    ListModel
    {
        id: authenticationModelTTLS
        ListElement { name: "None"}
        ListElement {name: "GTC"}
        ListElement {name: "MSCHAPV2"}
        ListElement {name: "MSCHAP"}
        ListElement {name: "PAP"}
    }

    ListModel
    {
        id: authenticationModelPEAP
        ListElement { name: "None"}
        ListElement {name: "GTC"}
        ListElement {name: "MSCHAPV2"}
    }

    ListModel
    {
        id: eapModel
        ListElement { name: "None"}
        ListElement {name: "TTLS"}
        ListElement {name: "TLS"}
        ListElement {name: "PEAP"}
    }

    Column {
        spacing: Theme.itemSpacingHuge
        width: parent.width
        anchors{
            top: parent.top
            topMargin: Theme.itemSpacingHuge
        }


        GlacierRoller {
            id: secureRoller
            width: parent.width

            onCurrentIndexChanged:
            {
                if (secureModel.get(currentIndex).name == "WPA/WPA2 PSK")
                {
                    passItem.visible = true
                    eapRoller.visible = false
                }
                else

                if (secureModel.get(currentIndex).name == "802.1x EAP")
                {
                    eapRoller.visible = true
                    passItem.visible = false
                }

            }

            clip: true
            model: secureModel
            label: qsTr("Security")
            delegate: GlacierRollerItem{
                Text{
                    height: secureRoller.itemHeight
                    verticalAlignment: Text.AlignVCenter
                    text: name
                    color: Theme.textColor
                    font.pixelSize: Theme.fontSizeMedium
                    font.bold: (secureRoller.activated && secureRoller.currentIndex === index)
                }
            }
        }


        Item
        {
            id: passItem
            width: parent.width
            height: childrenRect.height
            visible: false

            Text
            {
                text: qsTr("Password")
                color: Theme.textColor
                font.pointSize: Theme.fontSizeSmall
                id: pass

            }

            TextField
            {
                y: pass.height * 1.5
            }
        }

        GlacierRoller {
            id: eapRoller
            width: parent.width
            visible: false
            clip: true

            onCurrentIndexChanged:
            {
                if (eapModel.get(currentIndex).name == "TTLS")
                {
                    phaseRoller.visible = true
                    phaseRoller.model = authenticationModelTTLS
                }
                else
                    if (eapModel.get(currentIndex).name == "PEAP")
                    {
                        phaseRoller.visible = true
                        phaseRoller.model = authenticationModelPEAP
                    }
                else
                    phaseRoller.visible = false
            }

            model: eapModel
            label: qsTr("Eap Method")
            delegate: GlacierRollerItem{
                Text{
                    height: eapRoller.itemHeight
                    verticalAlignment: Text.AlignVCenter
                    text: name
                    color: Theme.textColor
                    font.pixelSize: Theme.fontSizeMedium
                    font.bold: (eapRoller.activated && eapRoller.currentIndex === index)
                }
            }
        }




        GlacierRoller {
            id: phaseRoller
            width: parent.width
            visible: false
            clip: true
            label: qsTr("Phase-2 Authentication")
            delegate: GlacierRollerItem{
                Text{
                    height: phaseRoller.itemHeight
                    verticalAlignment: Text.AlignVCenter
                    text: name
                    color: Theme.textColor
                    font.pixelSize: Theme.fontSizeMedium
                    font.bold: (phaseRoller.activated && phaseRoller.currentIndex === index)
                }
            }
        }










    }
}
