cmake_minimum_required(VERSION 3.22)

project(CXCOPY VERSION 0.1.0 DESCRIPTION "CxCopy Example" LANGUAGES NONE)

add_subdirectory(../.. Build/Debug/CxCopy)

include(${CX_SOURCE_DIR}/CxCopy.cmake)

CxCopy(FILE INPUT "${CX_SOURCE_DIR}/Data/CxCopy" OUTPUT "${CXCOPY_BINARY_DIR}/FileCopy" VAR files)
add_custom_target(FileCopy ALL DEPENDS ${files} COMMENT "CxCopy File test")


CxCopy(FILE INPUT "${CX_SOURCE_DIR}/Data/CxCopy" OUTPUT "${CXCOPY_BINARY_DIR}/FileCopyFilterIn" VAR files ONLY ".*(\\.txt)")
add_custom_target(FileCopyFilterIn ALL DEPENDS ${files} COMMENT "CxCopy File (filtered in) test")


CxCopy(FILE INPUT "${CX_SOURCE_DIR}/Data/CxCopy" OUTPUT "${CXCOPY_BINARY_DIR}/FileCopyFilterOut" VAR files EXCEPT ".*(\\.txt)")
add_custom_target(FileCopyFilterOut ALL DEPENDS ${files} COMMENT "CxCopy File (filtered out) test")


CxCopy(FILE RECURSIVE INPUT "${CX_SOURCE_DIR}/Data/CxCopy" OUTPUT "${CXCOPY_BINARY_DIR}/FileCopyR" VAR files)
add_custom_target(FileCopyR ALL DEPENDS ${files} COMMENT "CxCopy File recursively test")


CxCopy(FILE RECURSIVE INPUT "${CX_SOURCE_DIR}/Data/CxCopy" OUTPUT "${CXCOPY_BINARY_DIR}/FileCopyFilterInR" VAR files ONLY ".*(\\.txt)")
add_custom_target(FileCopyFilterInR ALL DEPENDS ${files} COMMENT "CxCopy File recursively (filtered in) test")


CxCopy(FILE RECURSIVE INPUT "${CX_SOURCE_DIR}/Data/CxCopy" OUTPUT "${CXCOPY_BINARY_DIR}/FileCopyFilterOutR" VAR files EXCEPT ".*(\\.txt)")
add_custom_target(FileCopyFilterOutR ALL DEPENDS ${files} COMMENT "CxCopy File (filtered out) test")


CxCopy(FOLDER INPUT "${CX_SOURCE_DIR}/Data/CxCopy" OUTPUT "${CXCOPY_BINARY_DIR}/FolderCopy" VAR files)
add_custom_target(FolderCopy ALL DEPENDS ${files} COMMENT "CxCopy Files and Folders test")


CxCopy(FOLDER INPUT "${CX_SOURCE_DIR}/Data/CxCopy" OUTPUT "${CXCOPY_BINARY_DIR}/FolderCopyFilterIn" VAR files ONLY ".*(\\.txt)")
add_custom_target(FolderCopyFilterIn ALL DEPENDS ${files} COMMENT "CxCopy Files and Folders (filtered in) test")


CxCopy(FOLDER INPUT "${CX_SOURCE_DIR}/Data/CxCopy" OUTPUT "${CXCOPY_BINARY_DIR}/FolderCopyFilterOut" VAR files EXCEPT ".*(\\.txt)")
add_custom_target(FolderCopyFilterOut ALL DEPENDS ${files} COMMENT "CxCopy Files and Folders (filtered out) test")


CxCopy(FOLDER RECURSIVE INPUT "${CX_SOURCE_DIR}/Data/CxCopy" OUTPUT "${CXCOPY_BINARY_DIR}/FolderCopyR" VAR files)
add_custom_target(FolderCopyR ALL DEPENDS ${files} COMMENT "CxCopy Files and Folders recursively test")


CxCopy(FOLDER RECURSIVE INPUT "${CX_SOURCE_DIR}/Data/CxCopy" OUTPUT "${CXCOPY_BINARY_DIR}/FolderCopyFilterInR" VAR files ONLY ".*(\\.txt)")
add_custom_target(FolderCopyFilterInR ALL DEPENDS ${files} COMMENT "CxCopy Files and Folders recursively (filtered in) test")


CxCopy(FOLDER RECURSIVE INPUT "${CX_SOURCE_DIR}/Data/CxCopy" OUTPUT "${CXCOPY_BINARY_DIR}/FolderCopyFilterOutR" VAR files EXCEPT ".*(\\.txt)")
add_custom_target(FolderCopyFilterOutR ALL DEPENDS ${files} COMMENT "CxCopy Files and Folders recursively (filtered out) test")


