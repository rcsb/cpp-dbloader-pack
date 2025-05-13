set(SOURCE_DIR_11  "modules/cpp-pdbml/src")
set(INCLUDE_DIR_11 "modules/cpp-pdbml/include")

set(SOURCE_DIR_12  "modules/cpp-db-loader/src")
set(INCLUDE_DIR_12 "modules/cpp-db-loader/include")
set(BIN_DIR_12  "modules/cpp-db-loader/bin")
set(TEST_DIR_12  "modules/cpp-db-loader/test")
#

#
#  Build 'schema-map' library - not integrated in main library
#
set(SOURCES_8
             "${SOURCE_DIR_8}/SchemaDataInfo.C"
	     "${SOURCE_DIR_8}/SchemaMap.C"
	     "${SOURCE_DIR_8}/SchemaMapCreate.C"
	     "${SOURCE_DIR_8}/SchemaParentChild.C"
	     )
add_library("schema-map" STATIC ${SOURCES_8})
target_include_directories("schema-map" PUBLIC ${INCLUDE_DIR_8} ${BUILD_INCLUDE_DIR} ${BUILD_SOURCE_DIR})


#
#  Build 'pdbml' library - not integrated in main library
#
set(SOURCES_11
             "${SOURCE_DIR_11}/PdbMlSchema.C"
             "${SOURCE_DIR_11}/PdbMlWriter.C"	
             "${SOURCE_DIR_11}/XmlWriter.C"
             "${SOURCE_DIR_11}/XsdWriter.C"	
	     )
add_library("pdbml" STATIC ${SOURCES_11})
target_include_directories("pdbml" PUBLIC ${INCLUDE_DIR_11} ${BUILD_INCLUDE_DIR} ${BUILD_SOURCE_DIR})



add_executable("db-loader" "${SOURCE_DIR_12}/db-loader.C"
			  "${SOURCE_DIR_12}/XmlOutput.C"
			  "${SOURCE_DIR_12}/CifSchemaMap.C")
target_link_libraries("db-loader" "pdbml" "schema-map" "mmciflib-all")
target_include_directories("db-loader" PUBLIC  ${INCLUDE_DIR_8} ${INCLUDE_DIR_12} ${BUILD_INCLUDE_DIR})

# One time copy of tests - a custom tatget to copy all the time might be https://stackoverflow.com/questions/697560/how-to-copy-directory-from-source-tree-to-binary-tree
file(GLOB TEST_GLOB "${TEST_DIR_12}/*")
file(COPY ${TEST_GLOB} DESTINATION test)

#
# export file: copy it to the build tree on every build invocation and add rule for installation
#
function (cm_export_file FILE DEST)
  if (NOT TARGET export-files)
    add_custom_target(export-files ALL COMMENT "Exporting files into build tree")
  endif (NOT TARGET export-files)
  get_filename_component(FILENAME "${FILE}" NAME)
  add_custom_command(TARGET export-files POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy_if_different "${CMAKE_CURRENT_SOURCE_DIR}/${FILE}" "${CMAKE_CURRENT_BINARY_DIR}/${DEST}/${FILENAME}")
  # install(FILES "${FILE}" DESTINATION "${DEST}")
endfunction (cm_export_file)

cm_export_file(scripts/RunTest.sh .)

enable_testing()
add_test(NAME GeneralTest COMMAND ./RunTest.sh Test.csh)
add_test(NAME TestLoader COMMAND ./RunTest.sh Test-loader.csh)
add_test(NAME TestLoaderDB2 COMMAND ./RunTest.sh Test-loader-db2.csh)
add_test(NAME TestUpdate COMMAND ./RunTest.sh Test-update.csh)
