#!/bin/sh
mkdir -p build
cd build/
unset ROS_ROOT
cmake -D CMAKE_BUILD_TYPE=Release -D RBDL_BUILD_ADDON_URDFREADER=ON -D RBDL_BUILD_ADDON_BENCHMARK=ON ../rbdl-rbdl-0879ee8c548a
make -j
addons/benchmark/benchmark --floating-base ../../atlas.urdf
