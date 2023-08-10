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

mac {
    cache()
}

#-------------------------------------------------------------------------------

CONFIG += c++14

# additional modules are pulled in via arcgisruntime.pri
QT += opengl qml quick 

ARCGIS_RUNTIME_VERSION = 100.11
include($$PWD/arcgisruntime.pri)

TEMPLATE = app
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

#-------------------------------------------------------------------------------

SOURCES += \\
    %{MainCppFileName}

RESOURCES += \\
    qml/qml.qrc \\
    Resources/Resources.qrc

OTHER_FILES += \\
    wizard.xml \\
    wizard.png

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
