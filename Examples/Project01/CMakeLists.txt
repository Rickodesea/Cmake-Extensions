cmake_minimum_required(VERSION 3.14)

project(PROJECT01 VERSION 1.0.0 DESCRIPTION "PROJECT01" LANGUAGES C)

add_executable(main
    main.c
)

add_library(core
    core.c
)

target_link_libraries(main PUBLIC core)

############################
## CxCopy
############################

# Basic use
CxCopy(main
    INPUT ${CMAKE_SOURCE_DIR}/Data/Images
    OUTPUT ${CMAKE_BINARY_DIR}/ImageBinaries
    FILE
    COMMENT "Copy all images to bin folder"
)

# File copy operations
CxCopy(main FILE INPUT "${CMAKE_SOURCE_DIR}/Data/General" OUTPUT "${CMAKE_BINARY_DIR}/General/FileCopy")
CxCopy(main FILE INPUT "${CMAKE_SOURCE_DIR}/Data/General" OUTPUT "${CMAKE_BINARY_DIR}/General/FileCopyFilterIn" ONLY ".*(\\.txt)")
CxCopy(main FILE INPUT "${CMAKE_SOURCE_DIR}/Data/General" OUTPUT "${CMAKE_BINARY_DIR}/General/FileCopyFilterOut" EXCEPT ".*(\\.txt)")

# Recursive file copy operations
CxCopy(main FILE RECURSIVE INPUT "${CMAKE_SOURCE_DIR}/Data/General" OUTPUT "${CMAKE_BINARY_DIR}/General/FileCopyR")
CxCopy(main FILE RECURSIVE INPUT "${CMAKE_SOURCE_DIR}/Data/General" OUTPUT "${CMAKE_BINARY_DIR}/General/FileCopyFilterInR" ONLY ".*(\\.txt)")
CxCopy(main FILE RECURSIVE INPUT "${CMAKE_SOURCE_DIR}/Data/General" OUTPUT "${CMAKE_BINARY_DIR}/General/FileCopyFilterOutR" EXCEPT ".*(\\.txt)")

# Folder copy operations
CxCopy(main FOLDER INPUT "${CMAKE_SOURCE_DIR}/Data/General" OUTPUT "${CMAKE_BINARY_DIR}/General/FolderCopy")
CxCopy(main FOLDER INPUT "${CMAKE_SOURCE_DIR}/Data/General" OUTPUT "${CMAKE_BINARY_DIR}/General/FolderCopyFilterIn" ONLY ".*(\\.txt)")
CxCopy(main FOLDER INPUT "${CMAKE_SOURCE_DIR}/Data/General" OUTPUT "${CMAKE_BINARY_DIR}/General/FolderCopyFilterOut" EXCEPT ".*(\\.txt)")

# Recursive folder copy operations
CxCopy(main FOLDER RECURSIVE INPUT "${CMAKE_SOURCE_DIR}/Data/General" OUTPUT "${CMAKE_BINARY_DIR}/General/FolderCopyR")
CxCopy(main FOLDER RECURSIVE INPUT "${CMAKE_SOURCE_DIR}/Data/General" OUTPUT "${CMAKE_BINARY_DIR}/General/FolderCopyFilterInR" ONLY ".*(\\.txt)")
CxCopy(main FOLDER RECURSIVE INPUT "${CMAKE_SOURCE_DIR}/Data/General" OUTPUT "${CMAKE_BINARY_DIR}/General/FolderCopyFilterOutR" EXCEPT ".*(\\.txt)")

############################
## CxFileCopy
############################

# core lib is built in build/Examples/Project01
# move it to build
CxFileCopy(core
    INPUT $<TARGET_FILE:core>
    OUTPUT ${CMAKE_BINARY_DIR}/$<TARGET_FILE_NAME:core>
)

# main exe is built in build/Examples/Project01
# move it to build
CxFileCopy(main 
    INPUT $<TARGET_FILE:main>
    OUTPUT ${CMAKE_BINARY_DIR}/main${CMAKE_EXECUTABLE_SUFFIX}
    COMMENT "Copying built main binary to build root"
)

############################
## CxShaderCompile
############################

CxShaderCompile(main
    INPUT ${CMAKE_SOURCE_DIR}/Data/Shaders
    OUTPUT ${CMAKE_BINARY_DIR}/ShaderBinaries
)