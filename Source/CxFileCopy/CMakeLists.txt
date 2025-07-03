cmake_minimum_required(VERSION 3.22)

project(CxFileCopyDemo)

add_subdirectory(../.. Build/Debug/CxFileCopy)

add_executable(MyApp main.c)

include(${CX_SOURCE_DIR}/CxFileCopy.cmake)

CxFileCopy(MyApp 
    INPUT "$<TARGET_FILE:MyApp>"
    OUTPUT "${CMAKE_BINARY_DIR}/MyAppCopy${CMAKE_EXECUTABLE_SUFFIX}"
    COMMENT "Copy built MyApp binary to build root"
)
