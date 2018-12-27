/*
 * Copyright (C) 2017 Chupligin Sergey <neochapay@gmail.com>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public License
 * along with this library; see the file COPYING.LIB.  If not, write to
 * the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301, USA.
 */
import QtQuick 2.6
import QtQuick.Window 2.1

import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

import MeeGo.Connman 0.2

import "../../components"
import Certificates 1.0

Page {
    id: wifiSettingsPage
    property var modelData

    headerTools: HeaderToolsLayout {
        id: header
        showBackButton: true;
        title: qsTr("Connect to")+" "+modelData.name
    }

    TechnologyModel {
        id: networkingModel
        name: "wifi"
        property bool sheetOpened
        property string networkName
    }

    UserAgent {
        id: userAgent
        onUserInputRequested: {
            console.log("USER INPUT REQUESTED");
            var view = {
                "fields": []
            };
            for (var key in fields) {
                view.fields.push({
                                     "name": key,
                                     "id": key.toLowerCase(),
                                     "type": fields[key]["Type"],
                                     "requirement": fields[key]["Requirement"]
                                 });
                console.log(key + ":");
                for (var inkey in fields[key]) {
                    console.log("    " + inkey + ": " + fields[key][inkey]);
                }
            }
        }

        onErrorReported: {
            console.log("Got error from model: " + error);
        }
    }

    Component.onCompleted: {
        networkingModel.networkName.text = modelData.name;
    }

    SettingsColumn{

        Label{
            visible: !view.visible
            id: nameLabel
            text: modelData.security[0]
            anchors{
                left: parent.left
            }
            wrapMode: Text.Wrap
            font.bold: true
        }

        TextField{
            visible: modelData.security[0] == "wep" || modelData.security[0] == "psk"
            id: passphrase
            text: modelData.passphrase
        }

        TextField{
            visible: !passphrase.visible && !view.visible && modelData.security[0] == "ieee8021x"
            id: certificate
            placeholderText: "Select sertificate"
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    view.visible = true
                }
            }
        }

        Button{
            visible: !view.visible
            id: connectButton
            height: Theme.itemHeightSmall

            onClicked: {
                if (modelData.security[0] == "wep" || modelData.security[0] == "psk")
                {
                    modelData.passphrase = passphrase.text;
                }
                else
                    if (modelData.security[0] == "ieee8021x")
                        modelData.caCertFile = cert.getPathByName(certificate.text, 0)

                modelData.requestConnect();
                networkingModel.networkName.text = modelData.name;
                pageStack.pop();
            }
            text: qsTr("Connect")
        }
    }


    ListView
    {
        id: view
        visible: false
        anchors.fill: parent
        model: cert.certList
        delegate: ListViewItemWithActions{
            label: modelData
            onClicked:
            {
                certificate.text = modelData
                view.visible = false
            }
        }
    }



    Connections {
        target: modelData
        onConnectRequestFailed: {
            console.log(error)
        }
    }
}
