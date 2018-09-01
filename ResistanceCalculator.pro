#
# Copyright (c) 2018 Alex Spataru <https://github.com/alex-spataru>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#

#-------------------------------------------------------------------------------
# Project configuration
#-------------------------------------------------------------------------------

TEMPLATE = app
TARGET = ResistanceCalculator

#-------------------------------------------------------------------------------
# Make options
#-------------------------------------------------------------------------------

UI_DIR = uic
MOC_DIR = moc
RCC_DIR = qrc
OBJECTS_DIR = obj

#-------------------------------------------------------------------------------
# Import Qt modules
#-------------------------------------------------------------------------------

QT += gui
QT += qml
QT += svg
QT += xml
QT += core
QT += quick
QT += quickcontrols2

DEFINES += QTADMOB_QML

#-------------------------------------------------------------------------------
# Include libraries
#-------------------------------------------------------------------------------

include ($$PWD/lib/QtAdMob/QtAdMob.pri)
include ($$PWD/lib/ShareUtils-QML/ShareUtils-QML.pri)

#-------------------------------------------------------------------------------
# Deploy configuration
#-------------------------------------------------------------------------------

linux:!android {
}

win32* {
}

macx* {
}

ios {
}

android {
    DEFINES += ENABLE_ADS
    DEFINES += MOBILE_RELEASE
    android:QT += androidextras gui-private

    DISTFILES += \
        $$PWD/deploy/android/AndroidManifest.xml \
        $$PWD/deploy/android/gradle/wrapper/gradle-wrapper.jar \
        $$PWD/deploy/android/gradlew \
        $$PWD/deploy/android/res/values/libs.xml \
        $$PWD/deploy/android/build.gradle \
        $$PWD/deploy/android/gradle/wrapper/gradle-wrapper.properties \
        $$PWD/deploy/android/gradlew.bat \
        $$PWD/deploy/android/res/values/apptheme.xml \
        $$PWD/deploy/android/res/drawable/splash.xml \
        $$PWD/deploy/android/src/org/dreamdev/QtAdMob/QtAdMobActivity.java

    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/deploy/android
}

#-------------------------------------------------------------------------------
# Import resources
#-------------------------------------------------------------------------------

RESOURCES += \
    $$PWD/assets/fonts/fonts.qrc \
    $$PWD/assets/icons/icons.qrc \
    $$PWD/assets/images/images.qrc \
    $$PWD/assets/qml/qml.qrc

#-------------------------------------------------------------------------------
# Import source code
#-------------------------------------------------------------------------------

HEADERS += \
    $$PWD/src/AppInfo.h \
    $$PWD/src/ResistanceInfo.h

SOURCES += \
    $$PWD/src/main.cpp \
    $$PWD/src/ResistanceInfo.cpp

OTHER_FILES += \
    $$PWD/assets/qml/Components/DrawerItem.qml \
    $$PWD/assets/qml/Components/PageDrawer.qml \
    $$PWD/assets/qml/Components/Resistance.qml \
    $$PWD/assets/qml/Components/ResistanceCalculatorWidgets.qml \
    $$PWD/assets/qml/Components/SvgImage.qml \
    $$PWD/assets/qml/Pages/About.qml \
    $$PWD/assets/qml/Pages/OpAmpCalculator.qml \
    $$PWD/assets/qml/Pages/ResistanceCalculator.qml \
    $$PWD/assets/qml/Pages/Settings.qml \
    $$PWD/assets/qml/Pages/SmdCalculator.qml \
    $$PWD/assets/qml/Ads.qml \
    $$PWD/assets/qml/main.qml \
    $$PWD/assets/qml/UI.qml

