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
import QtQuick.Controls.Material 2.0

import "Pages"
import "Components"

Page {
    //
    // Aliases
    //
    property alias toolbarTitle: toolbarText.text

    //
    // Loads the given page and changes the toolbar title
    //
    function loadPage (page, index) {
        stack.clear()
        toolbarTitle = drawer.items.get (index).pageTitle
        stack.push (page)
    }

    //
    // Decreases the stack depth when running on Android,
    // this function is called when the user presses the back
    // button on his/her device.
    //
    function checkStackDepth() {
        if (Qt.platform.os === "android") {
            if (drawer.index !== 0) {
                drawer.index = 0
                return false;
            }
        }

        return true
    }

    //
    // Opents the Resistors tutorial page from SparkFun
    //
    function learnAboutResistors() {
        Qt.openUrlExternally ("https://learn.sparkfun.com/tutorials/resistors")
    }

    //
    // Opens the URL to rate the application
    //
    function rateApplication() {
        if (Qt.platform.os === "android") {

        }

        else if (Qt.platform.os == "ios") {

        }

        else {
            Qt.openUrlExternally ("https://github.com/alex-spataru/resistor-calculator")
        }
    }


    //
    // Background rectangle (to dim screen when using camera)
    //
    background: Rectangle {
        onColorChanged: NumberAnimation{}
        color: imageToResistance.visible ? "#000" : Material.background
    }

    //
    // Toolbar
    //
    header: ToolBar {
        height: 56
        Material.primary: imageToResistance.visible ? "#000" : app.Material.primary

        RowLayout {
            spacing: 3/2 * app.spacing

            anchors {
                fill: parent
                margins: app.spacing
                leftMargin: 3/2 * app.spacing
                rightMargin: 3/2 * app.spacing
            }

            SvgImage {
                sourceSize: Qt.size (24, 24)
                source: "qrc:/icons/menu.svg"

                MouseArea {
                    anchors.fill: parent
                    onClicked: drawer.open()
                }
            }

            Label {
                id: toolbarText
                color: "#ffffff"
                font.weight: Font.Medium
                font.pixelSize: app.mediumLabel
            }

            Item {
                Layout.fillWidth: true
            }
        }
    }

    //
    // Drawer with application name and available pages
    //
    PageDrawer {
        z: 1
        id: drawer
        iconTitle: AppName
        iconBgColorLeft: Material.primary
        iconBgColorRight: Material.primary
        iconSource: "qrc:/images/logo.svg"
        iconSubtitle: qsTr ("Version %1").arg (AppVersion)
        iconSubSubtitle: qsTr ("Developed by %1").arg (AppDeveloper)
        height: AdsEnabled ? app.height - app.bannerHeight - 1 : app.height

        //
        // Define the actions to take for each drawer item
        // Drawers 5 and 6 are ignored, because they are used for
        // displaying a spacer and a separator
        //
        actions: {
            0: function() {loadPage (resistanceCalculator, 0)},
            1: function() {loadPage (imageToResistance, 1)},
            2: function() {loadPage (smdCalculator, 2)},
            3: function() {loadPage (opAmpCalculator, 3)},
            4: function() {loadPage (settings, 4)},
            // 5: ignored (separator)
            6: function() {learnAboutResistors()},
            7: function() {rateApplication()}
        }

        //
        // Define the drawer items
        //
        items: ListModel {
            id: pagesModel

            ListElement {
                pageTitle: qsTr ("Resistance Calculator")
                pageIcon: "qrc:/icons/calculator.svg"
            }

            ListElement {
                pageTitle: qsTr ("Scan Resistor")
                pageIcon: "qrc:/icons/camera.svg"
            }

            ListElement {
                pageTitle: qsTr ("SMD Calculator")
                pageIcon: "qrc:/icons/smd.svg"
            }

            ListElement {
                pageTitle: qsTr ("Op-Amp Calculator")
                pageIcon: "qrc:/icons/op-amp.svg"
            }

            ListElement {
                pageTitle: qsTr ("Settings")
                pageIcon: "qrc:/icons/settings.svg"
            }

            ListElement {
                separator: true
            }

            ListElement {
                link: true
                pageIcon: "qrc:/icons/help.svg"
                pageTitle: qsTr ("Learn about Resistors")
            }

            ListElement {
                link: true
                pageIcon: "qrc:/icons/star.svg"
                pageTitle: qsTr ("Rate This App")
            }
        }
    }

    //
    // Page loader
    //
    StackView {
        z: 2
        id: stack
        initialItem: resistanceCalculator

        anchors {
            fill: parent
            margins: app.spacing
            bottomMargin: app.spacing + app.bannerHeight
        }

        popExit: Transition {}
        popEnter: Transition {}
        pushExit: Transition {}
        pushEnter: Transition {}

        ResistanceCalculator {
            visible: false
            anchors.fill: parent
            id: resistanceCalculator

            anchors {
                fill: parent
                margins: -app.spacing
            }
        }

        ImageToResistance {
            visible: false
            id: imageToResistance

            anchors {
                fill: parent
                margins: -app.spacing
            }
        }

        SmdCalculator {
            visible: false
            id: smdCalculator
            anchors.fill: parent
        }

        OpAmpCalculator {
            visible: false
            id: opAmpCalculator

            anchors {
                fill: parent
                margins: -app.spacing
            }
        }

        Settings {
            id: settings
            visible: false
            anchors.fill: parent
        }
    }
}
