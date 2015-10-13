#We check that doxygen is available as a module.
set(Doxygen_FOUND FALSE)
foreach(l_IPM_repo ${IPM_module_repositories})
	unset(l_IPM_module_path)
	IPM_require_module(${l_IPM_repo} Doxygen l_IPM_module_path)
	if(DEFINED l_IPM_module_path)
		if(NOT "${l_IPM_module_path}" STREQUAL "")
			set(Doxygen_FOUND TRUE)
			break()
		endif()
	endif()
endforeach(l_IPM_repo)

if(${Doxygen_FOUND})
  include(${l_IPM_module_path}/compatibility.cmake)
  if(${Doxygen_COMPATIBLE})
    set(CMakeDoxygen_COMPATIBLE TRUE)
  else()
    set(CMakeDoxygen_COMPATIBLE FALSE)
    set(CMakeDoxygen_COMPATIBILITY_DETAILS "Doxygen module is required by CMakeDoxygen, but not compatible.")
  endif()
else()
  set(CMakeDoxygen_COMPATIBLE FALSE)
  set(CMakeDoxygen_COMPATIBILITY_DETAILS "Doxygen module is required by CMakeDoxygen.")
  return()
endif()