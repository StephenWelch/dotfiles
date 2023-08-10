
// Copyright 2019 ESRI
//
// All rights reserved under the copyright laws of the United States
// and applicable international laws, treaties, and conventions.
//
// You may freely redistribute and use this sample code, with or
// without modification, provided you include the original copyright
// notice and use restrictions.
//
// See the Sample code usage restrictions document for further information.
//

#include "%{CN}.h"

#include "ArcGISRuntimeEnvironment.h"
@if %{ThreeDSample}
#include "SceneQuickView.h"
@else
#include "MapQuickView.h"
@endif

#include <QDir>
#include <QGuiApplication>
@if %{ThreeDSample}
#include <QSurfaceFormat>
@endif
#include <QQmlApplicationEngine>

//------------------------------------------------------------------------------

using namespace Esri::ArcGISRuntime;

int main(int argc, char *argv[])
{
@if %{ThreeDSample}
  #if defined(Q_OS_LINUX) && !defined(Q_OS_ANDROID)
    // Linux requires 3.2 OpenGL Context
    // in order to instance 3D symbols
    QSurfaceFormat fmt = QSurfaceFormat::defaultFormat();
    fmt.setVersion(3, 2);
    QSurfaceFormat::setDefaultFormat(fmt);
#endif

@endif
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);    

    // Use of Esri location services, including basemaps and geocoding, requires
    // either an ArcGIS identity or an API key. For more information see
    // https://links.esri.com/arcgis-runtime-security-auth.

    // 1. ArcGIS identity: An ArcGIS named user account that is a member of an
    // organization in ArcGIS Online or ArcGIS Enterprise.

    // 2. API key: A permanent key that gives your application access to Esri
    // location services. Create a new API key or access existing API keys from
    // your ArcGIS for Developers dashboard (https://links.esri.com/arcgis-api-keys).

    const QString apiKey = QStringLiteral("");
    if (apiKey.isEmpty())
    {
      qWarning() << "Use of Esri location services, including basemaps, requires "
                    "you to authenticate with an ArcGIS identity or set the API Key property.";
    }
    else
    {
      ArcGISRuntimeEnvironment::setApiKey(apiKey);
    }

    // Production deployment of applications built with ArcGIS Runtime requires you to
    // license ArcGIS Runtime functionality. For more information see
    // https://links.esri.com/arcgis-runtime-license-and-deploy.

    // ArcGISRuntimeEnvironment::setLicense("Place license string in here");

@if %{ThreeDSample}
    // Register the scene view for QML
    qmlRegisterType<SceneQuickView>("Esri.%{ProjectName}", 1, 0, "SceneView");
@else
    // Register the map view for QML
    qmlRegisterType<MapQuickView>("Esri.%{ProjectName}", 1, 0, "MapView");
@endif

    // Register the %{CN} (QQuickItem) for QML
    qmlRegisterType<%{CN}>("Esri.%{ProjectName}", 1, 0, "%{CN}");

    // Initialize application view
    QQmlApplicationEngine engine;

    // Add the import Path
    engine.addImportPath(QDir(QCoreApplication::applicationDirPath()).filePath("qml"));

    // Set the source
    engine.load(QUrl("qrc:/qml/main.qml"));

    return app.exec();
}

//------------------------------------------------------------------------------
