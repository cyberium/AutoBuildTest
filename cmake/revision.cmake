#
# This file is part of the CMaNGOS Project. See AUTHORS file for Copyright information
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

# Function responsible to generate revision
#
# You can customize the input file and outputfile by setting
# INPUT_CORE_REVISION_FILE and OUTPUT_CORE_REVISION_FILE

if ("${INPUT_CORE_REVISION_FILE}" STREQUAL "")
  set(INPUT_CORE_REVISION_FILE "${CMAKE_SOURCE_DIR}/src/common/revision.h.in")
endif()

if ("${OUTPUT_CORE_REVISION_FILE}" STREQUAL "")
  set(OUTPUT_CORE_REVISION_FILE "${CMAKE_SOURCE_DIR}/src/common/revision.h")
endif()

function (GenerateRevision)
  # Find Git: used to get the revision number
  find_package(Git)

  # Find core revision
  if(GIT_EXECUTABLE)
    execute_process(
      COMMAND ${GIT_EXECUTABLE} rev-parse HEAD
      WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
      OUTPUT_VARIABLE REVISION_ID
      RESULT_VARIABLE GIT_RESULT
      ERROR_QUIET
      OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    if(GIT_RESULT)
      set(REVISION_ID "Git repository not found")
      set(REVISION_DATE "\"0000-00-00T00:00:00+00:00\"")
    else()
      execute_process(
        COMMAND ${GIT_EXECUTABLE} show --quiet --date=iso-strict --format="%ad" ${REVISION_ID}
        WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
        OUTPUT_VARIABLE REVISION_DATE
        RESULT_VARIABLE GIT_RESULT
        ERROR_QUIET
        OUTPUT_STRIP_TRAILING_WHITESPACE
      )
      if(GIT_RESULT)
        set(REVISION_DATE "\"0000-00-00T00:00:00+00:00\"")
      endif()
    endif()
  else()
    set(REVISION_ID "Git not found")
    set(REVISION_DATE "\"0000-00-00T00:00:00+00:00\"")
  endif()
  
  # Write revision file using data found above
  configure_file(
    "${INPUT_CORE_REVISION_FILE}"
    "${OUTPUT_CORE_REVISION_FILE}"
    @ONLY
  )

endfunction()