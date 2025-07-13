# CMake Extensions

A collection of useful CMake functions for your CMake projects.

## CxCopy

Copy files or folders with filtering options, with target association support.

### Features:
- FILE: Copy only files (exclude directories)
- FOLDER: Copy files and maintain directory structure
- RECURSIVE: Copy contents recursively
- INPUT: Source directory to copy from
- OUTPUT: Destination directory to copy to
- ONLY: Regex pattern to include only matching files
- EXCEPT: Regex pattern to exclude matching files
- VAR: Optional output variable for copied files list
- COMMENT: Custom comment message for the copy operation

### Target-aware:
- Automatically associates copy operations with a target using POST_BUILD
- If no target exists, creates file dependencies

### Usage Examples:
```cmake
# Basic file copy
CxCopy(main
    INPUT ${CMAKE_SOURCE_DIR}/Data/Images
    OUTPUT ${CMAKE_BINARY_DIR}/ImageBinaries
    FILE
)

# Recursive folder copy with filtering
CxCopy(main FOLDER RECURSIVE 
    INPUT "${CMAKE_SOURCE_DIR}/Data/General" 
    OUTPUT "${CMAKE_BINARY_DIR}/General/FolderCopyFilterInR" 
    ONLY ".*(\\.txt)"
)
```

## CxFileCopy

Simplified function for copying a single file with target association.

### Features:
- INPUT: Source file path
- OUTPUT: Destination file path
- COMMENT: Custom comment message

### Usage Example:
```cmake
# Copy built library to different location
CxFileCopy(core
    INPUT $<TARGET_FILE:core>
    OUTPUT ${CMAKE_BINARY_DIR}/$<TARGET_FILE_NAME:core>
    COMMENT "Copying built core library to build root"
)
```

## CxShaderCompile

Compile GLSL shaders to SPIR-V format with target association.

### Features:
- INPUT: Directory containing shader files
- OUTPUT: Directory for compiled SPIR-V files
- INCLUDE: Additional include directories for shaders
- COMMENT: Custom comment message
- Automatic detection of all common shader types (.vert, .frag, .comp, etc.)
- Creates dedicated shader compilation target

### Usage Example:
```cmake
CxShaderCompile(main
    INPUT ${CMAKE_SOURCE_DIR}/Data/Shaders
    OUTPUT ${CMAKE_BINARY_DIR}/ShaderBinaries
    INCLUDE ${CMAKE_SOURCE_DIR}/Shaders/Include
    COMMENT "Compiling shaders to SPIR-V"
)
```

## Common Features

All functions:
- Support generator expressions in paths
- Create output directories automatically
- Provide meaningful default comments
- Show relative paths in messages for cleaner output

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Version
The current version of this project can be seen in the [VERSION](VERSION.md) file.

## Authors
See [AUTHORS](AUTHORS) for full list.

## Contributing
See [CONTRIBUTING.md](CONTRIBUTING.md) for how to contribute.
