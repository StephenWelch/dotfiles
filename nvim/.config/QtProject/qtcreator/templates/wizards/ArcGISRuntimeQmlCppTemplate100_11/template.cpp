
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

@if %{ThreeDSample}
#include "ArcGISTiledElevationSource.h"
#include "Basemap.h"
#include "Scene.h"
#include "SceneQuickView.h"
@else
#include "Basemap.h"
#include "Map.h"
#include "MapQuickView.h"
@endif

#include <QUrl>

using namespace Esri::ArcGISRuntime;

%{CN}::%{CN}(QObject* parent /* = nullptr */): 
  QObject(parent),
@if %{ThreeDSample}
  m_scene(new Scene(BasemapStyle::%{BaseMapOption3D}, this))
@else
  m_map(new Map(BasemapStyle::%{BaseMapOption2D}, this))
@endif
{
@if %{ThreeDSample}
  // create a new elevation source from %{ElevationOption} rest service
  ArcGISTiledElevationSource* elevationSource = new ArcGISTiledElevationSource(
    QUrl("https://elevation3d.arcgis.com/arcgis/rest/services/WorldElevation3D/%{ElevationOption}/ImageServer"), this);
  
  // add the elevation source to the scene to display elevation
  m_scene->baseSurface()->elevationSources()->append(elevationSource);
@endif
}

%{CN}::~%{CN}()
{
}

@if %{ThreeDSample}
SceneQuickView* %{CN}::sceneView() const
{
  return m_sceneView;	 	
}

// Set the view (created in QML)
void %{CN}::setSceneView(SceneQuickView* sceneView)
{
  if (!sceneView || sceneView == m_sceneView)
  {
    return;
  }
  
  m_sceneView = sceneView;
  m_sceneView->setArcGISScene(m_scene);
  
  emit sceneViewChanged();
}
@else
MapQuickView* %{CN}::mapView() const
{
  return m_mapView;	 	
}

// Set the view (created in QML)
void %{CN}::setMapView(MapQuickView* mapView)
{
  if (!mapView || mapView == m_mapView)
  {
    return;
  }
  
  m_mapView = mapView;
  m_mapView->setMap(m_map);
  
  emit mapViewChanged();
}
@endif
