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

TARGET = %{ProjectName} 
TEMPLATE = app

CONFIG += c++14

# additional modules are pulled in via arcgisruntime.pri
QT += opengl widgets


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

win32:CONFIG += \\
    embed_manifest_exe

SOURCES += \\
    %{MainCppFileName} \\
    %{CN}.cpp 

HEADERS += \\
    %{CN}.h

#-------------------------------------------------------------------------------
