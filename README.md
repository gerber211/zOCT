\tableofcontents

# TRT HowTo {#trt_all}

## TRT Solution Structure

* **Source Code**
  * [modules](@ref trt_modules)
  * [samples](@ref trt_samples)
  * [applications](@ref trt_applications)
  * [plugins](@ref trt_plugins)
  * [tools](@ref trt_tools)
* **Configuration**
  * [cmake](@ref trt_cmake)
  * [settings](@ref trt_settings)
  * [test](@ref trt_test)
  * [resources](@ref trt_resources)
  * [CMakeLists.txt](CMakeLists.txt)
* **Documentation**
  * [docs](@ref trt_docs)
  * [This file](README.md)
  * [VERSION](VERSION.txt)

## TRT Target Types

Following target types are defined for configuring TRT projects;

|    Name         |    Target Kind    |    Dependent Type      |
|-----------------|:-----------------:|-----------------------:|
|    MODULE       |    Library        |    MODULE   (maybe)    |
|    APP          |    Executable     |    MODULE              |
|    SAMPLE       |    Executable     |    MODULE              |
|    TOOL         |    Executable     |    MODULE   (maybe)    |
|    PLUGIN       |    Library        |    MODULE              |
|    UNIT_TEST    |    Executable     |    MODULE              |
|    VERI_TEST    |    Executable     |    MODULE              |

## How to create a new module?

### Simple definition

* Define a new module name *MyModule*
* Create a new directory under *\<root>/sources/modules* with the name *MyModule*
* Create the following directory structure (NOTE: module names are case-sensitive!! Use camel-case for module names)
  * CMakeLists.txt
  * src
    * *source files*
  * include
    * czmtr
      * *MyModule*
        * *header files*
* Include the header in the source files using
    ```cpp
    #include "czmtr/MyModule/MyHeader.hpp"
    ```
* Define the cmake-lists file

```cmake
    #---------------------------------------------------------------------------------------
    #                         Copyright (©) Carl Zeiss Meditec AG
    #                               - All Rights Reserved -
    #
    #                     THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF
    #                                  CARL ZEISS MEDITEC AG
    #
    #                       This copyright notice does not evidence any
    #                    actual or intended publication of such source code.
    #---------------------------------------------------------------------------------------
    ##################################################
    # define a new module
    
    # optionally, create a list SYSTEM_DEPS for passing system dependencies
    set(SYSTEM_DEPS "")
    list(APPEND SYSTEM_DEPS "SYSTEM")
    if(WIN32)
        list(APPEND SYSTEM_DEPS "MyWindowsSystemDependency")
    elseif (UNIX)
        list(APPEND SYSTEM_DEPS "MyUnixSystemDependency")
    endif()
	
	set(TARGET_NAME "MyModule")
	set(TARGET_DESCRIPTION "TRT Module for the Good.")
	# enable/disable packaging of this module
	set(CREATE_PACKAGE ON)
	# use module definition macro for defining your module
	tr_define_module(${TARGET_NAME}
        EXTERNAL
            ExternalLibraryA
            ExternalLibraryB,1
            ExternalLibraryB,0
        INTERNAL
            ModuleA
            ModuleB
            ${SYSTEM_DEPS})
```

### Adding tests

### Creating package
Packaging of shared modules is possible by doing one of the followings 
* forcing all by turning this option ON
* setting CREATE_PACKAGE to ON in the CMakeLists.txt file of the respective shared module (see above)

## How to create a new application?

## How to create a new plugin?

## How to add a new dependency?

In order to add a new 3rd party (external) dependency to the TRT project, the [packages.json](./resources/packages.json) file nees to be modified by adding a new json vector *"dependency name"* for the new library.

```json
    {
    ....
        "dependency name": [
            {
                "index": 0-based, user defined index for this version of dependency,
                "nuget": {
                    "win32": {
                        "dev": {
                            "id": "nuget package id",
                            "version": "nuget pacakge version",
                            "targetframework": "native or managed"
                        }
                    }
                }
                "another package manager": {
                    ...
                }
            },
            {
                "index": a different configuration of the same library,
                "nuget": {
                    "win32": {
                        "dev": {
                            "id": "nuget package id",
                            "version": "nuget pacakge version",
                            "targetframework": "native or managed"
                        }
                    }
                }
            }
        ],
    ....
    }
```

Then, the dependency can be included in the CMakeLists.txt file as

```cmake
    tr_define_module(MyModule
        EXTERNAL
            <dependency name>,<index>
    )
```

When the dependency index is not specified, the one with the index 0 is going to be taken by default.


## How to add documentation?

Documentation can be added in two ways. 

1) Using README Markdown files for general module/sample documentation.
2) Using Doxygen style comments in source code for details documentation


### Requirements

#### Windows
* Doxygen (for generating HTML output from source code)
* MikTeX (for converting LaTeX formulas in source code to DVIPS)
  * newunicodechar package
  * This package can be installed automatically using MikTeX, if there is an internet connection. 
  * Otherwise, the following steps can be followed;
    * download the package from CTAN and prepare as described in its documentation
    * create a local TEXMF root directory and register it using MikTeX console
* Ghostscript for Windows (32 bit) (for DVIPS to PDF conversion)
  * gswin32c.exe should be in PATH
