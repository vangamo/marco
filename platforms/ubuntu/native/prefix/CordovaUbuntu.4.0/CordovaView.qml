/*
 *
 * Copyright 2013 Canonical Ltd.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 *
*/
import QtQuick 2.2
import CordovaUbuntu 4.0

Item {
    id: root
    property string wwwDir

    property var mainWebview
    property var cordovaObject: cordova

    Cordova {
        id: cordova
        wwwDir: root.wwwDir
    }
    Image {
        id: splashscreen
        anchors.fill: parent
    }
    Loader {
        id: loader
        asynchronous: true
        visible: false
        anchors.fill: parent

        onLoaded: {
            root.mainWebview = loader.item.mainWebview
            cordova.parent = loader.item

            loader.item.completed.connect(function() {
                loader.item.visible = true
                loader.visible = true
                splashscreen.visible = false
            });
        }
    }
    Component.onCompleted: {
        splashscreen.source = cordova.getSplashscreenPath()
        loader.source = "CordovaViewInternal.qml"
    }
}
