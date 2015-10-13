inquire_message(INFO "Triggering installation of CMakeDoxygen... ")

#---------------------------------------------------------------------------------------#
#-										DOWNLOAD									   -#
#---------------------------------------------------------------------------------------#
set(l_IPM_CMD_location "https://github.com/saschazelzer/CMakeDoxygenFilter/archive/master.tar.gz")
set(l_IPM_CMD_local_dir ${CMakeDoxygen_PACKAGE_ROOT})
set(l_IPM_CMD_local_archive "${CMakeDoxygen_PACKAGE_ROOT}/download/master.tar.gz")

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
if(EXISTS ${CMakeDoxygen_PACKAGE_ROOT}/source/master/FunctionCMakeDoxygenFilterCompile.cmake)
	inquire_message(INFO "Folder ${CMakeDoxygen_PACKAGE_ROOT}/source/master/ already exists. ")
else()
	inquire_message(INFO "Extracting CMakeDoxygen...")
	file(MAKE_DIRECTORY ${l_IPM_CMD_local_dir}/source/)
	execute_process(COMMAND ${CMAKE_COMMAND} -E tar xzf ${l_IPM_CMD_local_archive} WORKING_DIRECTORY ${l_IPM_CMD_local_dir}/source/)
	inquire_message(INFO "Extracting CMakeDoxygen... DONE.")
endif()
set(CMakeDoxygen_PACKAGE_VERSION_ROOT ${l_IPM_CMD_local_dir})
