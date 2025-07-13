# CxShaderCompile - Compile GLSL shaders to SPIR-V
#
# Usage:
#   CxShaderCompile(<target>
#       INPUT <shader_dir>
#       OUTPUT <output_dir>
#       [INCLUDE <include_dir>...]
#       [COMMENT <message>]
#   )
#
# Parameters:
#   target   - Target to associate the shader compilation with
#   INPUT    - Directory containing shader files
#   OUTPUT   - Directory to output compiled SPIR-V files
#   INCLUDE  - Optional include directories for shader compilation
#   COMMENT  - Optional custom comment message

#####################################
## Internal helper functions
#####################################

function(CxInternalGetRelPath path out_var)
  string(REGEX MATCH "\\$<.*>" is_gen "${path}")
  if(is_gen)
    set(${out_var} "${path}" PARENT_SCOPE)
  else()
    file(RELATIVE_PATH result "${CMAKE_SOURCE_DIR}" "${path}")
    set(${out_var} "${result}" PARENT_SCOPE)
  endif()
endfunction()

#####################################
## Main function
#####################################

function(CxShaderCompile target)
    set(req_params INPUT OUTPUT)
    set(single_values ${req_params})
    set(opt_params COMMENT)
    set(multi_values INCLUDE)
    set(options)

    cmake_parse_arguments(
        SC
        "${options}"
        "${single_values}"
        "${multi_values}"
        ${ARGN}
    )

    if(NOT SC_INPUT OR NOT SC_OUTPUT)
        message(FATAL_ERROR "[CxShaderCompile] Requires INPUT and OUTPUT arguments")
    endif()

    set(SHADER_SOURCE_DIR ${SC_INPUT})
    set(SHADER_OUTPUT_DIR ${SC_OUTPUT})

    CxInternalGetRelPath(${SHADER_SOURCE_DIR} display_input)
    CxInternalGetRelPath(${SHADER_OUTPUT_DIR} display_output)

    # Force output directory to be generated at configure time
    file(MAKE_DIRECTORY ${SHADER_OUTPUT_DIR})

    # glslangValidator (comes with VulkanSDK, ensure path global on windows)
    find_program(GLSLANG_VALIDATOR glslangValidator REQUIRED)

    # Glob shaders
    file(GLOB SHADER_SOURCES
        "${SHADER_SOURCE_DIR}/*.vert"
        "${SHADER_SOURCE_DIR}/*.frag"
        "${SHADER_SOURCE_DIR}/*.comp"
        "${SHADER_SOURCE_DIR}/*.geom"
        "${SHADER_SOURCE_DIR}/*.tesc"
        "${SHADER_SOURCE_DIR}/*.tese"
        "${SHADER_SOURCE_DIR}/*.mesh"
        "${SHADER_SOURCE_DIR}/*.task"
        "${SHADER_SOURCE_DIR}/*.rgen"
        "${SHADER_SOURCE_DIR}/*.rint"
        "${SHADER_SOURCE_DIR}/*.rahit"
        "${SHADER_SOURCE_DIR}/*.rchit"
        "${SHADER_SOURCE_DIR}/*.rmiss"
        "${SHADER_SOURCE_DIR}/*.rcall"
    )

    if(SHADER_SOURCES STREQUAL "")
        message(WARNING "[CxShaderCompile] No shader files found in ${SHADER_SOURCE_DIR}")
        return()
    endif()

    set(SPIRV_FILES)
    foreach(SHADER_FILE ${SHADER_SOURCES})
        get_filename_component(FILE_NAME ${SHADER_FILE} NAME)
        set(SPV_FILE ${SHADER_OUTPUT_DIR}/${FILE_NAME}.spv)
        get_filename_component(SPV_NAME ${SPV_FILE} NAME)

        # Build include paths
        set(INCLUDE_ARGS)
        foreach(INCLUDE_DIR ${SC_INCLUDE})
            list(APPEND INCLUDE_ARGS "-I${INCLUDE_DIR}")
        endforeach()

        # Set default comment if not provided
        set(comment_text "CxShaderCompile(${target}): Compiling ${display_input}/${FILE_NAME} to SPIR-V (${SPV_NAME}) and Copying to ${display_output}")
        if(SC_COMMENT)
            set(comment_text "${SC_COMMENT}")
        endif()

        add_custom_command(
            OUTPUT ${SPV_FILE}
            #COMMAND ${CMAKE_COMMAND} -E make_directory ${SPV_DIR}
            COMMAND ${GLSLANG_VALIDATOR} --quiet -V ${SHADER_FILE} -o ${SPV_FILE} ${INCLUDE_ARGS}
            DEPENDS ${SHADER_FILE}
            COMMENT "${comment_text}"
            BYPRODUCTS ${SPV_FILE}
            VERBATIM
        )

        list(APPEND SPIRV_FILES ${SPV_FILE})
    endforeach()

    # Add target that always checks shader dependencies
    add_custom_target(${target}_Shaders DEPENDS ${SPIRV_FILES})
    add_dependencies(${target} ${target}_Shaders)
endfunction()
