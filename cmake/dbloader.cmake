set(SOURCE_DIR_11  "modules/cpp-pdbml/src")
set(INCLUDE_DIR_11 "modules/cpp-pdbml/include")

set(SOURCE_DIR_12  "modules/cpp-db-loader/src")
set(INCLUDE_DIR_12 "modules/cpp-db-loader/include")
set(BIN_DIR_12  "modules/cpp-db-loader/bin")
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

