# directly from git instead of GH archives with vcpkg_from_github because repo is private
vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL git@github.com:jgd-solutions/jgd-cmake-modules.git
    REF 779104511f44d58ce1a81fec0a7410c739523f18
    HEAD_REF main)

file(READ "${CMAKE_CURRENT_LIST_DIR}/vcpkg.json" manifest)
string(JSON version ERROR_VARIABLE error GET "${manifest}" "version")
if (error)
  message(FATAL_ERROR "Failed to read version from manifest file: ${error}")
endif ()

vcpkg_cmake_configure(
  SOURCE_PATH "${SOURCE_PATH}"
  OPTIONS
    -DJCM_BUILD_TESTS=OFF
    -DJCM_BUILD_DOCS=OFF)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "share/cmake/${PORT}-${version}")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")
file(COPY "${CURRENT_PORT_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.md")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
