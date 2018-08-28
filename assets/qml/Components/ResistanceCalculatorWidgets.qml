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
import ResistanceInfo 1.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0

Item {
    id: widget

    // Custom Properties
    property bool sixStrip: false
    property bool fiveStrip: false
    property bool fourStrip: false

    //
    // Main interface layout
    //
    ColumnLayout {
        spacing: app.spacing
        anchors.fill: parent

        //
        // Spacer
        //
        Item {
            Layout.fillHeight: true
        }

        //
        // Resistance representation
        //
        Resistance {
            height: width / 5
            bodyColor: "#a68059"
            cableColor: "#a6a6a6"
            Layout.alignment: Qt.AlignHCenter
            width: Math.min (app.width / 2, 360)

            numberOfStrips: {
                if (sixStrip)
                    return 6

                else if (fiveStrip)
                    return 5

                return 4
            }
        }

        //
        // Spacer
        //
        Item {
            Layout.fillHeight: true
        }

        //
        // Selector
        //
        GridLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            rowSpacing: app.spacing
            columnSpacing: app.spacing * 2

            columns: 2
            Layout.alignment: Qt.AlignHCenter
            Layout.maximumWidth: Math.min (app.width - 4 * app.spacing, 360)

            //
            // 1st Digit controls (removes black from digit names list, so that
            // we avoid having 0-ohm resistors)
            //
            ComboBox {
                Layout.fillWidth: true
                displayText: qsTr ("1st Digit")
                model: ResistanceInfo.firstDigitNames
                currentIndex: ResistanceInfo.digitA - 1
                popup.height: Math.min (height * count, app.height * 0.29)

                onCurrentIndexChanged: {
                    if (ResistanceInfo.digitA !== currentIndex + 1)
                        ResistanceInfo.digitA = currentIndex + 1
                }
            }

            //
            // 2nd Digit controls
            //
            ComboBox {
                Layout.fillWidth: true
                displayText: qsTr ("2nd Digit")
                model: ResistanceInfo.digitNames
                currentIndex: ResistanceInfo.digitB
                popup.height: Math.min (height * count, app.height * 0.29)

                onCurrentIndexChanged: {
                    if (ResistanceInfo.digitB !== currentIndex)
                        ResistanceInfo.digitB = currentIndex
                }
            }

            //
            // 3rd Digit controls
            //
            ComboBox {
                visible: !fourStrip
                Layout.fillWidth: true
                displayText: qsTr ("3rd Digit")
                model: ResistanceInfo.digitNames
                currentIndex: ResistanceInfo.digitC
                popup.height: Math.min (height * count, app.height * 0.29)

                onCurrentIndexChanged: {
                    if (ResistanceInfo.digitC !== currentIndex)
                        ResistanceInfo.digitC = currentIndex
                }
            }

            //
            // Multiplier controls
            //
            ComboBox {
                Layout.fillWidth: true
                displayText: qsTr ("Multiplier")
                model: ResistanceInfo.multiplierNames
                currentIndex: ResistanceInfo.multiplier
                popup.height: Math.min (height * count, app.height * 0.29)

                onCurrentIndexChanged: {
                    if (ResistanceInfo.multiplier !== currentIndex)
                        ResistanceInfo.multiplier = currentIndex
                }
            }

            //
            // Tolerance controls
            //
            ComboBox {
                Layout.fillWidth: true
                displayText: qsTr ("Tolerance")
                model: ResistanceInfo.toleranceNames
                currentIndex: ResistanceInfo.tolerance
                popup.height: Math.min (height * count, app.height * 0.29)

                onCurrentIndexChanged: {
                    if (ResistanceInfo.tolerance !== currentIndex)
                        ResistanceInfo.tolerance = currentIndex
                }
            }

            //
            // Tempco
            //
            ComboBox {
                visible: sixStrip
                Layout.fillWidth: true
                displayText: qsTr ("Tempco")
                model: ResistanceInfo.tempcoNames
                currentIndex: ResistanceInfo.tempco
                popup.height: Math.min (height * count, app.height * 0.29)

                onCurrentIndexChanged: {
                    if (ResistanceInfo.tempco !== currentIndex)
                        ResistanceInfo.tempco = currentIndex
                }
            }
        }

        //
        // Spacer
        //
        Item {
            Layout.fillHeight: true
        }

        //
        // Resistor information widget
        //
        ColumnLayout {
            spacing: app.spacing
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter

            Label {
                Layout.fillWidth: true
                font.pixelSize: app.largeLabel
                horizontalAlignment: Label.AlignHCenter
                text: qsTr ("Resistance") + ": " + ResistanceInfo.resistance
            }

            Label {
                Layout.fillWidth: true
                horizontalAlignment: Label.AlignHCenter
                font.pixelSize: !fourStrip ? app.smallLabel : app.mediumLabel
                text: qsTr ("Min. Resistance") + ": " + ResistanceInfo.minimumResistance
            }

            Label {
                Layout.fillWidth: true
                horizontalAlignment: Label.AlignHCenter
                font.pixelSize: !fourStrip ? app.smallLabel : app.mediumLabel
                text: qsTr ("Max. Resistance") + ": " + ResistanceInfo.maximumResistance
            }

            Label {
                visible: sixStrip
                Layout.fillWidth: true
                font.pixelSize: app.smallLabel
                horizontalAlignment: Label.AlignHCenter
                text: qsTr ("Temp. Coefficient") + ": " + ResistanceInfo.tempcoStr
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
