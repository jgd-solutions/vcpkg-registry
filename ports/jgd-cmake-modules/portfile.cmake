vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO jgd-solutions/jgd-cmake-modules
    REF "28161be9582d161d58836c56bcae2672a75c442e"
    SHA512 "c28dabc96cc325ac9bb4cc9b98c4e365e1fdf721fe8050af529475c837e08c4b9da859b7fe82457ccedec34094482d62dde3d45399c6a5dd80f5bb19f389458d"
    HEAD_REF main)

vcpkg_cmake_configure(
  SOURCE_PATH "${SOURCE_PATH}"
  OPTIONS
    -DJCM_ENABLE_TESTS=OFF
    -DJCM_ENABLE_DOCS=OFF
    -DJCM_INSTALL_VERSIONED_PATHS=OFF)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup()
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.md")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")
file(COPY "${CURRENT_PORT_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
