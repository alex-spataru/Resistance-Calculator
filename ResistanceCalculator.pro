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
    android:QT += androidextras gui-private
}

#-------------------------------------------------------------------------------
# Import resources
#-------------------------------------------------------------------------------

RESOURCES += \
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

DISTFILES += \
    deploy/android/AndroidManifest.xml \
    deploy/android/gradle/wrapper/gradle-wrapper.jar \
    deploy/android/gradlew \
    deploy/android/res/values/libs.xml \
    deploy/android/build.gradle \
    deploy/android/gradle/wrapper/gradle-wrapper.properties \
    deploy/android/gradlew.bat \
    deploy/android/res/values/apptheme.xml \
    deploy/android/res/drawable/splash.xml

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/deploy/android
