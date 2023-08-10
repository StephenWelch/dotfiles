
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

// C++ API headers
#include "Basemap.h"

// Other headers
#include "%{CN}.h"

@if %{ThreeDSample}
#include "ArcGISTiledElevationSource.h"
#include "Scene.h"
#include "SceneGraphicsView.h"

#include <QUrl>
@else
#include "Map.h"
#include "MapGraphicsView.h"
@endif

using namespace Esri::ArcGISRuntime;

%{CN}::%{CN}(QWidget* parent /*=nullptr*/):
    QMainWindow(parent)
{
@if %{ThreeDSample}
    // Create a scene using the %{BaseMapOption3D} BasemapStyle
    Scene* scene = new Scene(BasemapStyle::%{BaseMapOption3D}, this);

    // create a new elevation source from %{ElevationOption} rest service
    ArcGISTiledElevationSource* elevationSource = new ArcGISTiledElevationSource(
        QUrl("https://elevation3d.arcgis.com/arcgis/rest/services/WorldElevation3D/%{ElevationOption}/ImageServer"), this);

    // add the elevation source to the scene to display elevation
    scene->baseSurface()->elevationSources()->append(elevationSource);

    // Create a scene view, and pass in the scene
    m_sceneView = new SceneGraphicsView(scene, this);

    // set the sceneView as the central widget
    setCentralWidget(m_sceneView);
@else
    // Create a map using the %{BaseMapOption2D} BasemapStyle
    m_map = new Map(BasemapStyle::%{BaseMapOption2D}, this);

    // Create the Widget view
    m_mapView = new MapGraphicsView(this);

    // Set map to map view
    m_mapView->setMap(m_map);

    // set the mapView as the central widget
    setCentralWidget(m_mapView);
@endif
}

// destructor
%{CN}::~%{CN}()
{
}
