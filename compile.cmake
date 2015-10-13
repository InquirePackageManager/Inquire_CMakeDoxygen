inquire_message(INFO "Triggering compilation of CMakeDoxygen...")

  include(${CMakeDoxygen_PACKAGE_VERSION_ROOT}/source/CMakeDoxygenFilter-master/FunctionCMakeDoxygenFilterCompile.cmake)

  FunctionCMakeDoxygenFilterCompile(OUT ${CMakeDoxygen_PACKAGE_VERSION_ROOT}/build/CMakeDoxygen.exe)

	inquire_message(INFO "Triggering compilation of CMakeDoxygen... OK")
