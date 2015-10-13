set(CMakeDoxygenFilter_DIR "${CMakeDoxygen_PACKAGE_VERSION_ROOT}/build/" CACHE PATH "Location of the CMake Doxygen filter")


#TODO : What is the minimum version supported ?
inquire_message(INFO "Requiring Doxygen as a dependency of CMakeDoxygen.")
IPM_require_package(Doxygen VERSION 1.8.10 FILES_TO_INCLUDE CMakeDoxygen_FILES_TO_INCLUDE)
