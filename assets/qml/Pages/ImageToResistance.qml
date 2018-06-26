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
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0

Item {
    id: page

    //
    // Instructions widget
    //
    Rectangle {
        color: "#000"
        id: textRectangle
        height: label.implicitHeight * 2.5

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        Label {
            id: label
            color: "#fff"
            font.pixelSize: app.mediumLabel
            verticalAlignment: Label.AlignVCenter
            horizontalAlignment: Label.AlignHCenter
            wrapMode: Label.WrapAtWordBoundaryOrAnywhere
            text: qsTr ("Scan the resistor with the camera " +
                        "to calculate its value")

            anchors {
                fill: parent
                topMargin: app.spacing
                margins: 3 * app.spacing
            }
        }
    }

    //
    // Camera View
    //
    Camera {
        id: camera
        enabled: page.visible

        anchors {
            fill: parent
            topMargin: textRectangle.height
        }
    }
}
