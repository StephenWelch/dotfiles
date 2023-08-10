#-------------------------------------------------
#  Copyright 2020 ESRI
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
cmake_minimum_required(VERSION 3.5)

project(%{ProjectName} LANGUAGES CXX)

set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake" ${CMAKE_MODULE_PATH})

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt5 COMPONENTS REQUIRED Core Widgets Multimedia Positioning Sensors)
find_package(ArcGISRuntime %{ArcGISVersion} COMPONENTS REQUIRED Cpp)

set(SOURCE_FILES
  %{MainCppFileName}
  %{CN}.cpp)

add_executable(%{ProjectName} ${SOURCE_FILES})

# Copy required dynamic libraries to the build folder as a post-build step.
if(DEFINED ArcGISRuntime_LIBRARIES)
  add_custom_command(TARGET %{ProjectName} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
    ${ArcGISRuntime_LIBRARIES}
    $<TARGET_FILE_DIR:%{ProjectName}>)
endif()

target_link_libraries(%{ProjectName} PRIVATE
  Qt5::Core
  Qt5::Widgets
  Qt5::Multimedia
  Qt5::Positioning
  Qt5::Sensors
  ArcGISRuntime::Cpp)
