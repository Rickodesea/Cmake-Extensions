function(CxCopyInternRemoveDir outvar files)
  set(input ${${files}})
  foreach(_hdr IN LISTS input)
    if(IS_DIRECTORY ${_hdr})
      list(REMOVE_ITEM input "${_hdr}")
    endif()
  endforeach()
  set(${outvar} ${input} PARENT_SCOPE)
endfunction()


macro(CxCopyInternSetFilterAndIn filter in)
set(filter "*")
set(in TRUE)
if(parsed_ONLY)
  set(filter ${parsed_ONLY})
endif()
if(parsed_EXCEPT)
  set(filter ${parsed_EXCEPT})
  set(in FALSE)
endif()
endmacro()

function(CxCopyInternCopy outvar files filterval inval relval inputval outputval)
  set(temp_input ${${files}})  
  if(filterval AND NOT filterval STREQUAL "*")
    foreach(_hdr IN LISTS temp_input)
      if(_hdr MATCHES ${filterval})
        if(NOT ${inval})
          list(REMOVE_ITEM temp_input "${_hdr}")
        endif()
      else()
        if(${inval})
          list(REMOVE_ITEM temp_input "${_hdr}")
        endif()
      endif()
    endforeach()
  else()
  #message("no filtering done")
  endif()

  set(temp_output)
  foreach(_hdr IN LISTS temp_input)
    if(relval)
      cmake_path(RELATIVE_PATH _hdr BASE_DIRECTORY "${inputval}" OUTPUT_VARIABLE _name)
    else()
      get_filename_component(_name "${_hdr}" NAME)
    endif()
    set(_bin_hdr "${outputval}/${_name}")
    list(APPEND temp_output "${_bin_hdr}")
    add_custom_command(OUTPUT "${_bin_hdr}"
        COMMAND ${CMAKE_COMMAND} -E copy_if_different "${_hdr}" "${_bin_hdr}"
        DEPENDS "${_hdr}")
    message("target copying: ${_name}")
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

if(parsed_FILE)
  if(parsed_RECURSIVE)
    message(STATUS "CxCopy: Copying files from ${input} recursively to ${output}")
    file(GLOB_RECURSE input_files "${input}/*")
    CxCopyInternRemoveDir(filesonly input_files)
    CxCopyInternSetFilterAndIn(filter in)
    set(relative FALSE)
    CxCopyInternCopy(filtered_files 
      filesonly ${filter} ${in} ${relative} ${input} ${output})
    if(parsed_VAR)
      set(${parsed_VAR} ${filtered_files} PARENT_SCOPE)
    endif()
  else()
    message(STATUS "CxCopy: Copying files from ${input} to ${output}")
    file(GLOB input_files "${input}/*")
    CxCopyInternRemoveDir(filesonly input_files)
    CxCopyInternSetFilterAndIn(filter in)
    set(relative FALSE)
    CxCopyInternCopy(filtered_files 
      filesonly ${filter} ${in} ${relative} ${input} ${output})
    if(parsed_VAR)
      set(${parsed_VAR} ${filtered_files} PARENT_SCOPE)
    endif()
  endif()
elseif(parsed_FOLDER)
  if(parsed_RECURSIVE)
    message(STATUS "CxCopy: Copying files and directories from ${input} recursively to ${output}")
    file(GLOB_RECURSE input_files "${input}/*")
    set(filesanddirs ${input_files})
    CxCopyInternSetFilterAndIn(filter in)
    set(relative TRUE)
    CxCopyInternCopy(filtered_files 
      filesanddirs ${filter} ${in} ${relative} ${input} ${output})
    if(parsed_VAR)
      set(${parsed_VAR} ${filtered_files} PARENT_SCOPE)
    endif()
  else()
    message(STATUS "CxCopy: Copying files and directories from ${input} to ${output}")
    file(GLOB input_files "${input}/*")
    set(filesanddirs ${input_files})
    CxCopyInternSetFilterAndIn(filter in)
    set(relative TRUE)
    CxCopyInternCopy(filtered_files 
      filesanddirs ${filter} ${in} ${relative} ${input} ${output})
    if(parsed_VAR)
      set(${parsed_VAR} ${filtered_files} PARENT_SCOPE)
    endif()
  endif()
endif()



endfunction()

