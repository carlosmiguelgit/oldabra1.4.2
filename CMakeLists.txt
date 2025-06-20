cmake_minimum_required(VERSION 3.16)

set(CMAKE_DISABLE_SOURCE_CHANGES ON)
set(CMAKE_DISABLE_IN_SOURCE_BUILD ON)

if (DEFINED ENV{VCPKG_DEFAULT_TRIPLET} AND NOT DEFINED VCPKG_TARGET_TRIPLET)
  set(VCPKG_TARGET_TRIPLET "$ENV{VCPKG_DEFAULT_TRIPLET}" CACHE STRING "The vcpkg triplet")
endif()

project(tfs CXX)

add_subdirectory(src)
add_executable(tfs ${tfs_SRC})

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

set_target_properties(tfs PROPERTIES CXX_STANDARD 17)
set_target_properties(tfs PROPERTIES CXX_STANDARD_REQUIRED ON)

if (NOT WIN32)
    add_compile_options(-Wall -Werror -pipe -fvisibility=hidden)
endif ()

set(CMAKE_CXX_FLAGS_PERFORMANCE "${CMAKE_CXX_FLAGS_RELEASE} -march=native")

if (CMAKE_COMPILER_IS_GNUCXX)
    add_compile_options(-fno-strict-aliasing)
endif ()

# Find packages.
find_package(cryptopp CONFIG)
if (CryptoPP_FOUND)
    set(Crypto++_LIBRARIES "cryptopp::cryptopp")
else()
    find_package(Crypto++ REQUIRED)
endif ()

find_package(fmt CONFIG)
if (NOT fmt_FOUND)
    find_package(fmt 6.1.2 REQUIRED)
endif()

find_package(unofficial-libmariadb CONFIG)
if (unofficial-libmariadb_FOUND)
    set(MYSQL_CLIENT_LIBS "unofficial::libmariadb")
else ()
    find_package(MySQL REQUIRED)
endif ()

find_package(Threads REQUIRED)
find_package(PugiXML CONFIG REQUIRED)

# ✅ ADICIONADO: ZLIB (necessário para Boost::iostreams)
find_package(ZLIB REQUIRED)

# LuaJIT
if (DEFINED USE_LUAJIT AND NOT USE_LUAJIT)
    set(FORCE_LUAJIT ${USE_LUAJIT})
else ()
    find_package(LuaJIT)
    set(FORCE_LUAJIT ${LuaJIT_FOUND})
endif ()
option(USE_LUAJIT "Use LuaJIT" ${FORCE_LUAJIT})

if (FORCE_LUAJIT)
    if (APPLE)
        set(CMAKE_EXE_LINKER_FLAGS "-pagezero_size 10000 -image_base 100000000")
    endif ()
else ()
    find_package(Lua REQUIRED)
endif ()

find_package(Boost 1.66.0 REQUIRED COMPONENTS system iostreams)

include_directories(
    ${Boost_INCLUDE_DIRS}
    ${Crypto++_INCLUDE_DIR}
    ${LUA_INCLUDE_DIR}
    ${MYSQL_INCLUDE_DIR}
    ${PUGIXML_INCLUDE_DIR}
)

target_link_libraries(tfs PRIVATE
    Boost::system
    Boost::iostreams
    fmt::fmt
    pugixml::pugixml
    ${CMAKE_THREAD_LIBS_INIT}
    ${Crypto++_LIBRARIES}
    ${LUA_LIBRARIES}
    ${MYSQL_CLIENT_LIBS}
    ZLIB::ZLIB        # ✅ Adicionado aqui
)

# IPO / LTO
cmake_policy(SET CMP0069 NEW)
include(CheckIPOSupported)
check_ipo_supported(RESULT result OUTPUT error)
if (result)
    message(STATUS "IPO / LTO enabled")
    set_target_properties(tfs PROPERTIES INTERPROCEDURAL_OPTIMIZATION True)
else ()
    message(STATUS "IPO / LTO not supported: <${error}>")
endif ()

# Git metadata
option(SKIP_GIT "Skip checking for git updates" OFF)
if(NOT SKIP_GIT)
    set(PRE_CONFIGURE_FILE "cmake/gitmetadata.h.in")
    set(POST_CONFIGURE_FILE "${CMAKE_CURRENT_BINARY_DIR}/gitmetadata.h")
    include(git_watcher)
    if(Git_FOUND)
        add_dependencies(tfs check_git)
        target_include_directories(tfs PRIVATE ${CMAKE_CURRENT_BINARY_DIR})
    endif()
endif()

target_precompile_headers(tfs PUBLIC src/otpch.h)
