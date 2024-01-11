function(CxCopyInternRemoveDir outvar files)
  set(input ${${files}})
  foreach(_hdr IN LISTS input)
    if(IS_DIRECTORY ${_hdr})
      list(REMOVE_ITEM input "${_hdr}")
    endif()
  endforeach()
  set(${outvar} ${input} PARENT_SCOPE)
endfunction()

function(CxCopyInternCopy outvar files filterval inval relval inputval outputval)
  message("outvar: ${outvar}, files: ${${files}}, filterval: ${filterval}, inval: ${inval}, relval: ${relval}, inputval: ${inputval}, outputval: ${outputval}")
  set(temp_input ${${files}})  
  message("files: ${temp_input}")
  if(filterval AND NOT filterval STREQUAL "*")
    message("filtering by: ${filterval}, FOR: ${inval}")
    foreach(_hdr IN LISTS temp_input)
      if(_hdr MATCHES filterval)
        if(NOT ${inval})
          list(REMOVE_ITEM temp_input "${_hdr}")
        endif()
      else()
        if(${inval})
          list(REMOVE_ITEM temp_input "${_hdr}")
        endif()
      endif()
    endforeach()
  endif()

  message("after filtering: ${temp_input}")
  set(temp_output)
  message("inputval: ${inputval}, outputval: ${outputval}")
  foreach(_hdr IN LISTS temp_input)
    if(relval)
      cmake_path(RELATIVE_PATH _hdr BASE_DIRECTORY "${inputval}" OUTPUT_VARIABLE _name)
    else()
      get_filename_component(_name "${_hdr}" NAME)
    endif()
    message("filename: ${_name}")
    set(_bin_hdr "${outputval}/${_name}")
    list(APPEND temp_output "${_bin_hdr}")
    add_custom_command(OUTPUT "${_bin_hdr}"
        COMMAND ${CMAKE_COMMAND} -E copy_if_different "${_hdr}" "${_bin_hdr}"
        DEPENDS "${_hdr}")
  endforeach()
  set(${outvar} ${temp_output} PARENT_SCOPE)
endfunction()

function(CxCopy)

set(entry_modifier FILE FOLDER)
set(recurse_modifier RECURSIVE)
set(options ${entry_modifier} ${recurse_modifier})
set(req_params INPUT OUTPUT)
set(single_values ${req_params} VAR)
set(opt_params ONLY EXCEPT)
set(multi_values ${opt_params})

cmake_parse_arguments(
    parsed                  # prefix
    "${options}"            # options
    "${single_values}"      # one-value keywords
    "${multi_values}"       # multi-value keywords
    ${ARGN}                 # strings to parse
)

#message("multi_values: ${multi_values}")
#message("input: ${parsed_INPUT}")
#message("output: ${parsed_OUTPUT}")
#message("unparsed: ${parsed_UNPARSED_ARGUMENTS}")
#message("missing: ${parsed_KEYWORDS_MISSING_VALUES}")

if(NOT parsed_FILE AND NOT parsed_FOLDER)
  message(FATAL_ERROR "Missing either of keyword: ${entry_modifier}")
endif()

if(NOT parsed_INPUT)
message(FATAL_ERROR "Keyword (and value) required: INPUT")
endif()

if(NOT parsed_OUTPUT)
message(FATAL_ERROR "Keyword (and value) required: OUTPUT")
endif()

if(parsed_KEYWORDS_MISSING_VALUES)
  message(FATAL_ERROR "Following Keywords are missing parameters: ${parsed_KEYWORDS_MISSING_VALUES}")
endif()

if(parsed_UNPARSED_ARGUMENTS)
  message(WARNING 
  "Following parameters are unrecognized: ${parsed_KEYWORDS_MISSING_VALUES}")
endif()

string(COMPARE EQUAL ${parsed_INPUT} "" input_EMPTY)
if(input_EMPTY)
message(FATAL_ERROR "INPUT folder can not be empty")
endif()

string(COMPARE EQUAL ${parsed_OUTPUT} "" output_EMPTY)
if(output_EMPTY)
message(FATAL_ERROR "OUTPUT folder can not be empty")
endif()

set(input ${parsed_INPUT})
set(output ${parsed_OUTPUT})
message("SHORT *******: ${input}, ${output}")

if(parsed_FILE)
  if(parsed_RECURSIVE)
    message(STATUS "CxCopy: Copying files from ${input} recursively to ${output}")
  else()
    message(STATUS "CxCopy: Copying files from ${input} to ${output}")
    file(GLOB input_files "${input}/*")
    CxCopyInternRemoveDir(filesonly input_files)
    message("filesonly: ${filesonly}")
    set(filter "*")
    set(in TRUE)
    set(relative FALSE)
    CxCopyInternCopy(filtered_files 
      filesonly ${filter} ${in} ${relative} ${input} ${output})
    message("final: ${filtered_files}")
    if(parsed_VAR)
      set(${parsed_VAR} ${filtered_files} PARENT_SCOPE)
    endif()
  endif()
elseif(parse_FOLDER)
  if(parsed_RECURSIVE)
    message(STATUS "CxCopy: Copying files and directories from ${input} recursively to ${output}")
  else()
    message(STATUS "CxCopy: Copying files and directories from ${input} to ${output}")
  endif()
endif()



endfunction()

# if(parsed_UNPARSED_ARGUMENTS)
#     message(FATAL_ERROR "Bad arguments: ${parsed_UNPARSED_ARGUMENTS}")
# endif()

# if(parsed_KEYWORDS_MISSING_VALUES)
#     message(FATAL_ERROR "Missing values for: ${parsed_KEYWORDS_MISSING_VALUES}")
# endif()
# message(STATUS "Copying Files from ${SRC_FOLDER} to ${DST_FOLDER}")
# file(GLOB_RECURSE SRC_FOLDER_FILES ${SRC_FOLDER}/*)
# set(SRC_FOLDER_COPIED_FILES)
# foreach(_hdr IN LISTS SRC_FOLDER_FILES)
#   if(_hdr MATCHES "${ARGV2}")
#     list(REMOVE_ITEM SRC_FOLDER_FILES "${_hdr}")
#   else()
#     cmake_path(RELATIVE_PATH _hdr BASE_DIRECTORY "${SRC_FOLDER}" OUTPUT_VARIABLE _name)
#     set(_bin_hdr "${DST_FOLDER}/${_name}")
#     list(APPEND SRC_FOLDER_COPIED_FILES "${_bin_hdr}")
#     add_custom_command(OUTPUT "${_bin_hdr}"
#         COMMAND ${CMAKE_COMMAND} -E copy_if_different "${_hdr}" "${_bin_hdr}"
#         DEPENDS "${_hdr}")
#   endif()
# endforeach()
# set(${FILES_OUTPUT} ${SRC_FOLDER_COPIED_FILES} PARENT_SCOPE)
# endfunction()