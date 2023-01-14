vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO jgd-solutions/jgd-cmake-modules
    REF ad6475ef30462e8cf3d6f747bad35ae97e79d407
    SHA512 18f5539f2e4dcce932afc03cfda30d7f23e16502160f01156b440d06ad03f750b90d6e625dc53138d9b24e42b3d51fa8d15230f498573594d164f9d8797acd0a
    HEAD_REF main)

file(READ "${CMAKE_CURRENT_LIST_DIR}/vcpkg.json" manifest)
string(JSON version ERROR_VARIABLE error GET "${manifest}" "version")
if(error)
  message(FATAL_ERROR "Failed to read version from manifest file: ${error}")
endif()

vcpkg_cmake_configure(
  SOURCE_PATH "${SOURCE_PATH}"
  OPTIONS
    -DJCM_BUILD_TESTS=OFF
    -DJCM_BUILD_DOCS=OFF)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "share/cmake/${PORT}-${version}")
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.md")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")
file(COPY "${CURRENT_PORT_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
