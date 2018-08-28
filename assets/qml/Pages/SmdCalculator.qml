/*
 * Copyright (c) 2018 Alex Spataru <https://github.com/alex-spataru>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0

Item {
    id: page

    //
    // Main UI layout
    //
    ColumnLayout {
        anchors.fill: parent
        spacing: app.spacing

        //
        // Spacer
        //
        Item {
            Layout.fillHeight: true
        }

        //
        // Instructions
        //
        Label {
            font.italic: true
            Layout.fillWidth: true
            font.pixelSize: app.normalLabel
            Layout.alignment: Qt.AlignHCenter
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Label.WrapAtWordBoundaryOrAnywhere

            Layout.maximumWidth: {
                if (app.width > app.height)
                    app.width * 0.8
                else
                    app.width - 4 * app.spacing
            }

            text: qsTr ("Type the marking on the SMD resistor...")
        }

        //
        // Resistor value marker
        //
        Label {
            Layout.fillWidth: true
            font.pixelSize: app.largeLabel
            Layout.alignment: Qt.AlignHCenter
            horizontalAlignment: Label.AlignHCenter
            text: qsTr ("Resistance") + ": " + ResistanceInfo.smdResistance
        }

        //
        // Spacer
        //
        Item {
            height: 2 * app.spacing
        }

        //
        // SMD resistor representation
        //
        RowLayout {
            spacing: -5
            height: width / 3
            Layout.alignment: Qt.AlignHCenter
            width: Math.min (app.height, app.width) * 0.8

            Rectangle {
                z: 0
                radius: 5
                color: "#bebebe"
                height: parent.height
                width: parent.width / 6
            }

            //
            // Resistor body
            //
            Rectangle {
                z: 1
                color: "#000000"
                height: parent.height
                width: parent.width * 2/3

                TextInput {
                    focus: true
                    color: "#fff"
                    maximumLength: 4
                    anchors.fill: parent
                    anchors.centerIn: parent
                    font.family: "Roboto Mono"
                    font.pixelSize: app.largeLabel * 2
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    onTextChanged: ResistanceInfo.smdResistanceCode = text
                    Component.onCompleted: text = ResistanceInfo.smdResistanceCode
                }
            }

            Rectangle {
                z: 0
                radius: 5
                color: "#bebebe"
                height: parent.height
                width: parent.width / 6
            }
        }

        //
        // Spacer
        //
        Item {
            Layout.fillHeight: true
        }
    }
}
