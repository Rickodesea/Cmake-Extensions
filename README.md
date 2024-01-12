# Cmake_Extensions

## CxCopy

Copy files from one directory to another directory.  
The output directory is created if it doesn't exist.
See [Source](Source/) for examples.

* FILE copy only files
* FOLDER copy files along with their folder structure
* INPUT input folder
* OUTPUT output folder
* VAR store the list of copied files (destination)
* RECURSIVE copy files from subdirectory
* ONLY filter for files that matches the regex
* EXCEPT filter against files that matches the regex


```cmake
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

```

## License
This project is licensed under the mit license - see the [LICENSE](LICENSE) file for details.
© All rights reserved.

## Version
The current version of this project can be seen on the [VERSION](VERSION.md) file.

## Authors
See [AUTHORS](AUTHORS) for full list.

## Contributing
See [CONTRIBUTING.md](CONTRIBUTING.md) for how to contribute.


<br/><br/>
