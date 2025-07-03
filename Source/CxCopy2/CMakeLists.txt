cmake_minimum_required(VERSION 3.22)

project(CxCopy2Demo)

add_subdirectory(../.. Build/Debug/CxCopy2)

add_executable(MyApp main.c)

include(${CX_SOURCE_DIR}/CxCopy2.cmake)

CxCopy(MyApp FILE INPUT "${CX_SOURCE_DIR}/Data/CxCopy2" OUTPUT "${CMAKE_BINARY_DIR}/OutCopy" COMMENT "Copying data post-build")
