#-------------------------------------------------
#  Copyright 2019 ESRI
#
#  All rights reserved under the copyright laws of the United States
#  and applicable international laws, treaties, and conventions.
#
#  You may freely redistribute and use this sample code, with or
#  without modification, provided you include the original copyright
#  notice and use restrictions.
#
#  See the Sample code usage restrictions document for further information.
#-------------------------------------------------

TEMPLATE = app

CONFIG += c++14

# additional modules are pulled in via arcgisruntime.pri
QT += opengl qml quick

TARGET = %{ProjectName}

equals(QT_MAJOR_VERSION, %{MinQtMajor}) {
    lessThan(QT_MINOR_VERSION, %{MinQtMinor}) { 
        error("$$TARGET requires Qt %{MinQtMajor}.%{MinQtMinor}.%{MinQtPatch}")
    }
	equals(QT_MINOR_VERSION, %{MinQtMinor}) : lessThan(QT_PATCH_VERSION, %{MinQtPatch}) {
		error("$$TARGET requires Qt %{MinQtMajor}.%{MinQtMinor}.%{MinQtPatch}")
	}
}

equals(QT_MAJOR_VERSION, 6) {
  error("This version of the ArcGIS Runtime SDK for Qt is incompatible with Qt 6")
}

ARCGIS_RUNTIME_VERSION = %{ArcGISVersion}
include($$PWD/arcgisruntime.pri)

HEADERS += \\
    %{CN}.h

SOURCES += \\
    %{MainCppFileName} \\
    %{CN}.cpp

RESOURCES += \\
    qml/qml.qrc \\
    Resources/Resources.qrc

#-------------------------------------------------------------------------------

win32 {
    include (Win/Win.pri)
}

macx {
    include (Mac/Mac.pri)
}

ios {
    include (iOS/iOS.pri)
}

android {
    include (Android/Android.pri)
}
