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

import "Pages"
import "Components"

ApplicationWindow {
    id: app

    //
    // Constants
    //
    readonly property int spacing: 8
    readonly property int smallLabel: 12
    readonly property int largeLabel: 22
    readonly property int mediumLabel: 18
    readonly property int normalLabel: 16
    readonly property int extraSmallLabel: 10
    readonly property int extraLargeLabel: 24
    readonly property int bannerHeight: AdsEnabled ? 50 : 0

    //
    // Opens the link to disable ads, which depends on
    // the operating system in which the application is
    // currently running.
    //
    function removeAds() {

    }

    //
    // Show a simple dialog with app name, app version,
    // developers and contact methods
    //
    function showAboutDialog() {

    }

    //
    // Window options
    //
    width: 320
    height: 480
    visible: true

    //
    // Display the application window on launch
    //
    Component.onCompleted: {
        if (Qt.platform.os === "android")
            showMaximized()
        else
            showNormal()
    }

    //
    // Decrease stack depth before closing the application.
    // This allows the Android user to use the back button to navigate the UI
    //
    onClosing: close.accepted = ui.checkStackDepth()

    //
    // Material style options
    //
    Material.accent: "#e67e22"
    Material.primary: "#00979d"
    Material.theme: Material.Light

    //
    // Main UI of the application
    //
    UI {
        id: ui

        anchors {
            fill: parent
            bottomMargin: bannerHeight
        }
    }
}
