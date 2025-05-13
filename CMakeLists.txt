cmake_minimum_required(VERSION 3.12)

message("Cmake version: ${CMAKE_VERSION}")

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(BuildType)
set(CMAKE_DISABLE_SOURCE_CHANGES ON)
set(CMAKE_DISABLE_IN_SOURCE_BUILD ON)

project(dbloader C CXX)


message(STATUS "Compiler flags " ${CMAKE_CXX_FLAGS})

#
# ---------------------------------------------------------------
#   WHERE AM I RUNNING
#
message(STATUS "---CMAKE MODULE PATH - " ${CMAKE_MODULE_PATH})
message(STATUS "---CMAKE SOURCE DIR  - " ${CMAKE_SOURCE_DIR})
message(STATUS "---CMAKE PROJECT DIR - " ${PROJECT_SOURCE_DIR})
# ---------------------------------------------------------------
#
set(BUILD_SOURCE_DIR "${CMAKE_CURRENT_BINARY_DIR}/src")
set(BUILD_INCLUDE_DIR "${CMAKE_CURRENT_BINARY_DIR}/include")
set(BUILD_BINARY_DIR "${CMAKE_CURRENT_BINARY_DIR}/bin")
set(BUILD_LIBRARY_DIR "${CMAKE_CURRENT_BINARY_DIR}/lib")

include(cmake/commonparser.cmake)
include(cmake/dbloader.cmake)


#
#
# Distribution CPack configuration
#
set(CPACK_PACKAGE_VERSION_MAJOR "4")
set(CPACK_PACKAGE_VERSION_MINOR "5")
set(CPACK_PACKAGE_VERSION_PATCH "dev0")
set(CPACK_SOURCE_GENERATOR "TBZ2;TGZ")
if(NOT DEFINED CPACK_SOURCE_PACKAGE_FILE_NAME)
  set(CPACK_SOURCE_PACKAGE_FILE_NAME
    "${CMAKE_PROJECT_NAME}-v${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR}${CPACK_PACKAGE_VERSION_PATCH}-prod-src")
endif(NOT DEFINED CPACK_SOURCE_PACKAGE_FILE_NAME)

set(CPACK_SOURCE_IGNORE_FILES
  "/build/;/.bzr/;.git/;/.gitmodules;/.github/;/.gitignore;~$;/.*/.git;/.*/.svn;.idea/;${CPACK_SOURCE_IGNORE_FILES}")
# Inspired by https://jtanx.github.io/2019/08/22/cmake-dist-customisation/ package selected dictionaries
#set(CPACK_INSTALL_SCRIPT "${CMAKE_CURRENT_BINARY_DIR}/CPackExtraDist.cmake")
#  configure_file("${CMAKE_SOURCE_DIR}/cmake/ExtraDist.cmake.in" "CPackExtraDist.cmake" @ONLY)
include(CPack)
add_custom_target(dist
    COMMAND "${CMAKE_COMMAND}" --build "${CMAKE_BINARY_DIR}" --target package_source
    # DEPENDS test_dependencies
    VERBATIM
    USES_TERMINAL
  )
