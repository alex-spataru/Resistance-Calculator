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

import "../Components"

Item {
    id: page

    //
    // Main interface layout
    //
    ColumnLayout {
        spacing: app.spacing
        anchors.fill: parent

        //
        // Tab layout
        //
        TabBar {
            id: tabBar
            Layout.fillWidth: true
            currentIndex: ResistanceInfo.resistorType

            onCurrentIndexChanged: {
                swipeView.currentIndex = currentIndex
                ResistanceInfo.resistorType = currentIndex
            }

            TabButton {
                text: qsTr ("4 Strip")
            }

            TabButton {
                text: qsTr ("5 Strip")
            }

            TabButton {
                text: qsTr ("6 Strip")
            }
        }

        //
        // Pages
        //
        SwipeView {
            id: swipeView
            Layout.fillWidth: true
            Layout.fillHeight: true
            onCurrentIndexChanged: tabBar.currentIndex = currentIndex

            ResistanceCalculatorWidgets {
                fourStrip: true
                id: fourStripWidgets
            }

            ResistanceCalculatorWidgets {
                fiveStrip: true
                id: fiveStripWidgets
            }

            ResistanceCalculatorWidgets {
                sixStrip: true
                id: sixStripWidgets
            }
        }
    }
}
