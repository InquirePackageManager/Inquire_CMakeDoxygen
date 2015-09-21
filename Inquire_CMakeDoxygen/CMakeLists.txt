cmake_minimum_required (VERSION 3.0.0)
project (CMakeDoxygenTestProject)

include(${CMAKE_CURRENT_LIST_DIR}/../../Inquire/Inquire.cmake)

set(IPM_install_Doxygen ON CACHE BOOL "")
set(IPM_install_CMakeDoxygen ON CACHE BOOL "")

# an IPM module repository is a place (folder, GIT repo, etc.) containing CMake modules to "require" projects.
inquire_add_module_repository(moduleRepo FOLDER "${CMAKE_CURRENT_SOURCE_DIR}/../")
inquire_add_module_repository(doxygenModuleRepo FOLDER "${CMAKE_CURRENT_SOURCE_DIR}/../../Inquire_Doxygen/")

# an IPM package repository contains all the built libraries and sources.
inquire_add_package_repository(packageRepo FOLDER "${CMAKE_CURRENT_BINARY_DIR}/packages/")

require_package(Doxygen VERSION 1.8.10)
require_package(CMakeDoxygen VERSION 1.0)

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/Doxyfile.in ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile @ONLY)
add_doxygen_target("${CMAKE_CURRENT_BINARY_DIR}/Doxyfile" doc "${CMAKE_CURRENT_BINARY_DIR}/doc")

	#! \brief Brief doc.
	#!
	#!  Extended description...
function(dummy_function_with_doc)
endfunction()
