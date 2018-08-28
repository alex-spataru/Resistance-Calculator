/*
 * Copyright (c) 2017 Alex Spataru <alex_spataru@outlook.com>
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

RowLayout {
    id: resistor

    //
    // Properties
    //
    property int digitA: 0
    property int digitB: 0
    property int digitC: 0
    property int tolerance: 0
    property int multiplier: 0
    property int stripWidth: 4
    property int numberOfStrips: 4
    property string bodyColor: "#000"
    property string cableColor: "#000"

    //
    // Layout configuration
    //
    spacing: -2

    //
    // Spacer
    //
    Item {
        Layout.fillWidth: true
    }

    //
    // Left cable
    //
    Rectangle {
        z: 0
        width: 2
        height: parent.height / 2
        color: resistor.cableColor
        Layout.alignment: Qt.AlignBottom
    } Rectangle {
        z: 0
        height: 2
        radius: height
        width: parent.width / 8
        color: resistor.cableColor
        Layout.alignment: Qt.AlignVCenter
    }

    //
    // First 'bump'
    //
    Rectangle {
        z: 1
        radius: height / 4
        height: parent.height
        width: parent.width / 8
        color: resistor.bodyColor
        Layout.alignment: Qt.AlignVCenter

        Rectangle {
            width: resistor.stripWidth
            color: ResistanceInfo.resistanceStripColors [0]

            Behavior on color { ColorAnimation {} }

            anchors {
                top: parent.top
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
        }
    }

    //
    // Main resistance body
    //
    Rectangle {
        z: 1
        width: parent.width / 2
        color: resistor.bodyColor
        height: parent.height * 0.8
        Layout.alignment: Qt.AlignVCenter

        RowLayout {
            spacing: app.spacing

            anchors {
                fill: parent
                leftMargin: app.spacing
                rightMargin: app.spacing
            }

            Rectangle {
                height: parent.height
                width: resistor.stripWidth
                color: ResistanceInfo.resistanceStripColors [1]

                Behavior on color { ColorAnimation {} }
            }

            Rectangle {
                height: parent.height
                width: resistor.stripWidth
                opacity: numberOfStrips > 4 ? 1 : 0
                color: ResistanceInfo.resistanceStripColors [2]

                Behavior on color { ColorAnimation {} }
                Behavior on opacity { NumberAnimation {} }
            }

            Rectangle {
                height: parent.height
                width: resistor.stripWidth
                color: ResistanceInfo.resistanceStripColors [3]

                Behavior on color { ColorAnimation {} }
            }

            Item {
                Layout.fillWidth: true
            }

            Rectangle {
                height: parent.height
                width: resistor.stripWidth
                opacity: numberOfStrips >= 6 ? 1 : 0
                color: ResistanceInfo.resistanceStripColors [4]

                Behavior on color { ColorAnimation {} }
                Behavior on opacity { NumberAnimation {} }
            }
        }
    }

    //
    // Second 'bump'
    //
    Rectangle {
        z: 1
        radius: height / 4
        height: parent.height
        width: parent.width / 8
        color: resistor.bodyColor
        Layout.alignment: Qt.AlignVCenter

        Rectangle {
            width: resistor.stripWidth
            color: ResistanceInfo.resistorType === RI.SixStripResistor ?
                       ResistanceInfo.resistanceStripColors [5] :
                       ResistanceInfo.resistanceStripColors [4]

            Behavior on color { ColorAnimation {} }

            anchors {
                top: parent.top
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
        }
    }

    //
    // Right cable
    //
    Rectangle {
        z: 0
        height: 2
        radius: height
        width: parent.width / 8
        color: resistor.cableColor
        Layout.alignment: Qt.AlignVCenter
    } Rectangle {
        z: 0
        width: 2
        height: parent.height / 2
        color: resistor.cableColor
        Layout.alignment: Qt.AlignBottom
    }

    //
    // Spacer
    //
    Item {
        Layout.fillWidth: true
    }
}
