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
import QtMultimedia 5.8

Item {
    id: cameraWidget

    //
    // Start/stop the camera when the widget is enabled or disabled
    //
    onEnabledChanged: {
        if (enabled)
            camera.start()
        else
            camera.stop()
    }

    //
    // Camera engine
    //
    Camera {
        id: camera
        flash.mode: Camera.FlashOff
        onCameraStateChanged: {
            if (state === Camera.ActiveState)
                searchAndLock()
        }
    }

    //
    // Auto-focus every 2 seconds
    //
    Timer {
        repeat: true
        interval: 2000
        Component.onCompleted: start()

        onTriggered: {
            if (cameraWidget.visible)
                camera.searchAndLock()
        }
    }

    //
    // Focus when user taps screen
    //
    MouseArea {
        anchors.fill: parent
        onClicked: camera.searchAndLock()
    }

    //
    // Camera view
    //
    VideoOutput {
        source: camera
        anchors.fill: parent
        autoOrientation: true
        fillMode: VideoOutput.PreserveAspectCrop
    }

    //
    // 'Fingerprint Scanner' widget
    //
    Rectangle {
        id: scannerWidget

        radius: 5
        height: width
        color: "transparent"
        anchors.centerIn: parent
        width: Math.min (parent.height, parent.width) * 3/4

        border {
            width: 3
            color: "#fff"
        }

        Rectangle {
            radius: width / 2
            color: "transparent"

            anchors {
                fill: parent
                margins: parent.width / 6
            }

            border {
                width: 3
                color: scannerWidget.border.color
            }
        }
    }
}
