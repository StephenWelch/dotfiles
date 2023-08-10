
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

#ifndef %{IncludeGuard}
#define %{IncludeGuard}

namespace Esri
{
  namespace ArcGISRuntime
  {
@if %{ThreeDSample}
    class Scene;
    class SceneQuickView;
@else
    class Map;
    class MapQuickView;
@endif
  }
}

#include <QObject>

class %{CN} : public QObject
{
  Q_OBJECT

@if %{ThreeDSample}
  Q_PROPERTY(Esri::ArcGISRuntime::SceneQuickView* sceneView READ sceneView WRITE setSceneView NOTIFY sceneViewChanged)
@else
  Q_PROPERTY(Esri::ArcGISRuntime::MapQuickView* mapView READ mapView WRITE setMapView NOTIFY mapViewChanged)
@endif

public:
  explicit %{CN}(QObject* parent = nullptr);
  ~%{CN}() override;

signals:
@if %{ThreeDSample}
  void sceneViewChanged();
@else
  void mapViewChanged();
@endif
  
private:
@if %{ThreeDSample}
  Esri::ArcGISRuntime::SceneQuickView* sceneView() const;
  void setSceneView(Esri::ArcGISRuntime::SceneQuickView* sceneView);
	
  Esri::ArcGISRuntime::Scene* m_scene = nullptr;
  Esri::ArcGISRuntime::SceneQuickView* m_sceneView = nullptr;
@else
  Esri::ArcGISRuntime::MapQuickView* mapView() const;
  void setMapView(Esri::ArcGISRuntime::MapQuickView* mapView);
	
  Esri::ArcGISRuntime::Map* m_map = nullptr;
  Esri::ArcGISRuntime::MapQuickView* m_mapView = nullptr;
@endif
};

#endif // %{IncludeGuard}
