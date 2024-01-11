cmake_minimum_required(VERSION 3.22)

project(CXCOPY VERSION 0.1.0 DESCRIPTION "CxCopy Example" LANGUAGES NONE)

add_subdirectory(../.. Build/Debug/CxCopy)

include(${CX_SOURCE_DIR}/CxCopy.cmake)

CxCopy(FILE INPUT "${CX_SOURCE_DIR}/Data/CxCopy" OUTPUT "${CXCOPY_BINARY_DIR}/FileCopy" VAR files)

add_custom_target(cxcopy ALL DEPENDS ${files} COMMENT "CxCopy File test")
message("copied files: ${files}")

