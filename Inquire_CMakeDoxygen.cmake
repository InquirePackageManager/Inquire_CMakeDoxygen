function(check_package_compatibility a_IPM_result)
  set(${a_IPM_result} TRUE PARENT_SCOPE)
endfunction()

#there is no versionning. we simply put the source in the root dir
function(get_compatible_package_version_root a_IPM_package_root a_IPM_version a_IPM_result)
  set(${a_IPM_result} ${a_IPM_package_root} PARENT_SCOPE)
endfunction()

function(download_package_version a_IPM_package_root a_IPM_result a_IPM_version)
	inquire_message(INFO "Triggering installation of CMakeDoxygen... ")

	#---------------------------------------------------------------------------------------#
	#-										DOWNLOAD									   -#
	#---------------------------------------------------------------------------------------#
	set(l_IPM_CMD_location "https://github.com/saschazelzer/CMakeDoxygenFilter/archive/master.tar.gz")
	set(l_IPM_CMD_local_dir ${a_IPM_package_root})
	set(l_IPM_CMD_local_archive "${a_IPM_package_root}/download/master.tar.gz")

	if(NOT EXISTS "${l_IPM_CMD_local_archive}")
		inquire_message(INFO "Downloading CMakeDoxygen from ${l_IPM_CMD_location}.")
		file(DOWNLOAD "${l_IPM_CMD_location}" "${l_IPM_CMD_local_archive}" SHOW_PROGRESS STATUS l_IPM_download_status)
		list(GET l_IPM_download_status 0 l_IPM_download_status_code)
		list(GET l_IPM_download_status 1 l_IPM_download_status_string)
		if(NOT l_IPM_download_status_code EQUAL 0)
			inquire_message(FATAL_ERROR "Error: downloading ${l_IPM_CMD_location} failed with error : ${l_IPM_download_status_string}")
		endif()
	else()
			inquire_message(INFO "Using already downloaded Boost version from ${l_IPM_CMD_local_archive}")
	endif()

	#---------------------------------------------------------------------------------------#
	#-										EXTRACT 									   -#
	#---------------------------------------------------------------------------------------#
	if(EXISTS ${a_IPM_package_root}/source/master/FunctionCMakeDoxygenFilterCompile.cmake)
		inquire_message(INFO "Folder ${a_IPM_package_root}/source/master/ already exists. ")
	else()
		inquire_message(INFO "Extracting CMakeDoxygen...")
		file(MAKE_DIRECTORY ${l_IPM_CMD_local_dir}/source/)
		execute_process(COMMAND ${CMAKE_COMMAND} -E tar xzf ${l_IPM_CMD_local_archive} WORKING_DIRECTORY ${l_IPM_CMD_local_dir}/source/)
		inquire_message(INFO "Extracting CMakeDoxygen... DONE.")
	endif()

	set(${a_IPM_result} ${l_IPM_CMD_local_dir} PARENT_SCOPE)
endfunction()

function(package_version_need_compilation a_IPM_package_version_root a_IPM_result)
	set(${a_IPM_result} TRUE PARENT_SCOPE)
endfunction()

function(compile_package_version a_IPM_package_version_root a_IPM_result)
	IPM_compile_package_version_parse_arguments(l_IPM_compile_package ${ARGN})

	inquire_message(INFO "Triggering compilation of CMakeDoxygen...")

  include(${a_IPM_package_version_root}/source/CMakeDoxygenFilter-master/FunctionCMakeDoxygenFilterCompile.cmake)

  FunctionCMakeDoxygenFilterCompile(OUT ${a_IPM_package_version_root}/build/CMakeDoxygen.exe)

	inquire_message(INFO "Triggering compilation of CMakeDoxygen... OK")
endfunction()

function(configure_package_version a_IPM_package_version_root)
	IPM_configure_package_version_parse_arguments(l_IPM_configure_package_version ${ARGN})

  set(CMakeDoxygenFilter_DIR "${a_IPM_package_version_root}/build/" CACHE PATH "Location of the CMake Doxygen filter")
endfunction()
