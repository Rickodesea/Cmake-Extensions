cmake_minimum_required(VERSION 3.14)

project(CX VERSION 0.1.0 DESCRIPTION "CMAKE-EXTENSIONS" LANGUAGES NONE)

include(cmake/CxCopy.cmake)
include(cmake/CxFileCopy.cmake)
include(cmake/CxShaderCompile.cmake)

add_subdirectory(Examples)