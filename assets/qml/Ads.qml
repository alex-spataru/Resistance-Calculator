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
import QtQuick.Window 2.0
import QtQuick.Controls.Material 2.0
import com.dreamdev.QtAdMobBanner 1.0

Item {
    id: ads

    //
    // Holds the height of the banner ad
    //
    property int adHeight: 0

    //
    // Locates the banner on the bottom of the screen
    //
    function locateBanner() {
        if (AdsEnabled) {
            var w = bannerAd.width / DevicePixelRatio
            var h = bannerAd.height / DevicePixelRatio

            adHeight = h
            bannerAd.x = (Screen.width - w) * DevicePixelRatio / 2
            bannerAd.y = (Screen.height - h) * DevicePixelRatio
        }

        else {
            adHeight = 0
            bannerAd.x = Screen.width * 2 * DevicePixelRatio
            bannerAd.y = Screen.height * 2 * DevicePixelRatio
        }
    }

    //
    // Update banner location when window size changes
    //
    Connections {
        target: app
        onWidthChanged: locateBanner()
        onHeightChanged: locateBanner()
    }

    //
    // Banner ad
    //
    AdMobBanner {
        id: bannerAd
        onLoaded: locateBanner()
        visible: ads.enabled && AdsEnabled

        Component.onCompleted: {
            if (AdsEnabled) {
                unitId = AdBannerId
                size = AdMobBanner.SmartBanner
            }
        }
    }
}
