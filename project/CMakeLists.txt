cmake_minimum_required(VERSION 3.28)
project(test)

## Set the C++ standard
set(CMAKE_CXX_STANDARD 20)

# valgrind 检测内存泄漏的命令
#/usr/bin/valgrind --tool=memcheck --log-file=valgrind_output.log --gen-suppressions=all --leak-check=full --leak-resolution=med --track-origins=yes --vgdb=no /IdeaProjects/Dev_Container/project/cmake-build-debug/main


# 假设 CMakeLists.txt 在 src 同级目录

set(SOURCE_DIR ${CMAKE_SOURCE_DIR}/source)
set(BINARY_DIR ${CMAKE_BINARY_DIR})

# 检查并打印编译器信息
message(STATUS "C++ compiler ID is: ${CMAKE_CXX_COMPILER_ID}")
message(STATUS "C++ compiler version is: ${CMAKE_CXX_COMPILER_VERSION}")

message(STATUS "CMAKE_SOURCE_DIR = ${CMAKE_SOURCE_DIR}")
message(STATUS "CMAKE_BINARY_DIR = ${CMAKE_BINARY_DIR}")


# 使用 llvm 的 C++库

## 指定编译器标志
#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -I/opt/homebrew/opt/llvm/include -I/opt/homebrew/opt/llvm/include/c++/v1")

## 指定链接器标志
#set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -L/opt/homebrew/opt/llvm/lib/c++ -L/opt/homebrew/opt/llvm/lib -lunwind")

#-- CMAKE_SOURCE_DIR = /Users/ouyangzhaoxin/Downloads/Dev_Container/project
#-- CMAKE_BINARY_DIR = /Users/ouyangzhaoxin/Downloads/Dev_Container/project/cmake-build-debug


# 将文件从源目录复制到二进制目录
configure_file(${SOURCE_DIR}/Text.txt ${BINARY_DIR}/Text.txt COPYONLY)
# Add executable
add_executable(main src/main.cpp)