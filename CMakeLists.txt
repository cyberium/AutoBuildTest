###############################################################################
# Part of CMaNGOS Project
###############################################################################

# Minimum required cmake version to run the build
cmake_minimum_required(VERSION 3.18)

# Force out-of-source build
if("${CMAKE_SOURCE_DIR}" STREQUAL "${CMAKE_BINARY_DIR}")
  message(FATAL_ERROR
    "This project requires an out of source build. Remove the file 'CMakeCache.txt' found in this directory before continuing, create a separate build directory and run 'cmake [options] <srcs>' from there."
  )
endif()

# Define the project name and where to report bugs.
set(PACKAGE_BUGREPORT "https://github.com/cmangos/issues/issues")

# Project name
project(CMaNGOS_Classic CXX C)

# Configure the Compiler options, we will be using C++11 features.
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Force 64 bit package
set(ENV{VCPKG_DEFAULT_TRIPLET} "x64-windows")

# Define vcpkg folders
set(_VCPKG_DEFAULT_CACHE_FOLDER "${CMAKE_SOURCE_DIR}/../_VCPkgBinaryCache")
get_filename_component(_VCPKG_DEFAULT_CACHE_FOLDER "${_VCPKG_DEFAULT_CACHE_FOLDER}" REALPATH)
set(_VCPKG_DEFAULT_BINARY_CACHE "${_VCPKG_DEFAULT_CACHE_FOLDER}/archives")
set(ENV{VCPKG_DEFAULT_BINARY_CACHE} "${_VCPKG_DEFAULT_BINARY_CACHE}")
if(NOT EXISTS "${_VCPKG_DEFAULT_BINARY_CACHE}")
  file(MAKE_DIRECTORY "${_VCPKG_DEFAULT_BINARY_CACHE}")
  message(STATUS "Creating vcpkg cache folder to $_VCPKG_DEFAULT_BINARY_CACHE")
endif()

# Add custom modules path
list(APPEND CMAKE_MODULE_PATH "cmake")
list(APPEND CMAKE_MODULE_PATH "cmake/vcpkg")

# Include custom modules
include(AutoVcpkg) # Using VCPkg as package manager
include(revision)  # Revision generator

# Invoke needed packages installation
vcpkg_install(ZLIB OpenSSL libmysql BZip2 boost-system boost-program-options boost-thread boost-regex recast)

# Include toolchain to be able to find installed packages
include(${CMAKE_TOOLCHAIN_FILE})

# Check if package were correctly installed
find_package(ZLIB REQUIRED)
find_package(OpenSSL REQUIRED)
find_package(libmysql REQUIRED)
find_package(BZip2 REQUIRED)
find_package(Boost COMPONENTS system program_options thread regex REQUIRED)
find_library(RECAST_LIBRARY
    NAMES recast.lib
	PATH_SUFFIXES lib
)

# Generate revision for this build
GenerateRevision()

add_executable(test_auto_vcpkg "${CMAKE_SOURCE_DIR}/src/common/test_auto_vcpkg.cpp")
target_link_libraries(test_auto_vcpkg ZLIB::ZLIB BZip2::BZip2 OpenSSL::SSL OpenSSL::Crypto ${MYSQL_LIBRARIES} ${Boost_LIBRARIES} ${RECAST_LIBRARY})

