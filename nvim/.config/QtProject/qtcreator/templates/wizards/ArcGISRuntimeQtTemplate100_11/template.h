
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
        class SceneGraphicsView;
@else
        class Map;
        class MapGraphicsView;
@endif
  }
}

#include <QMainWindow>

class %{CN} : public QMainWindow
{
  Q_OBJECT
public:
  explicit %{CN}(QWidget* parent = nullptr);
  ~%{CN}() override;

public slots:

private:
@if %{ThreeDSample}
    Esri::ArcGISRuntime::SceneGraphicsView*     m_sceneView = nullptr;
@else
    Esri::ArcGISRuntime::Map*                   m_map = nullptr;
    Esri::ArcGISRuntime::MapGraphicsView*       m_mapView = nullptr;
@endif
};

#endif // %{IncludeGuard}
