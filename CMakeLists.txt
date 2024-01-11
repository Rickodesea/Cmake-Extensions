cmake_minimum_required(VERSION 3.22)

project(CX VERSION 0.1.0 DESCRIPTION "CMAKE-EXTENSIONS" LANGUAGES NONE)

add_custom_target(Cx ALL
    COMMENT "Cmake Extensions Target"
    WORKING_DIRECTORY ${CX_SOURCE_DIR}
    DEPENDS 
        ${CX_SOURCE_DIR}/CxCopy.cmake
)

