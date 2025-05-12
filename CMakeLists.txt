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
