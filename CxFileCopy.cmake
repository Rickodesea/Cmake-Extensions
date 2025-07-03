# CxFileCopy(target INPUT <src> OUTPUT <dst>)
function(CxFileCopy target)
    set(req_params INPUT OUTPUT)
    set(single_values ${req_params})
    set(opt_params COMMENT)
    set(multi_values)
    set(options)

    cmake_parse_arguments(
        parsed
        "${options}"
        "${single_values}"
        "${multi_values}"
        ${ARGN}
    )

    foreach(param IN LISTS req_params)
        if(NOT parsed_${param})
            message(FATAL_ERROR "CxFileCopy: Missing required keyword: ${param}")
        endif()
    endforeach()

    set(src ${parsed_INPUT})
    set(dst ${parsed_OUTPUT})

    set(comment_text "CxFileCopy: Copying ${src} to ${dst}")
    if(parsed_COMMENT)
        set(comment_text "${parsed_COMMENT}")
    endif()

    add_custom_command(
        TARGET ${target} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different "${src}" "${dst}"
        COMMENT "${comment_text}"
    )
endfunction()
