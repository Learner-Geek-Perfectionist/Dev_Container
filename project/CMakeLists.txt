cmake_minimum_required(VERSION 3.28)
project(test)

## Set the C++ standard
set(CMAKE_CXX_STANDARD 17)

# valgrind 检测内存泄漏的命令
#/usr/bin/valgrind --tool=memcheck --log-file=valgrind_output.log --gen-suppressions=all --leak-check=full --leak-resolution=med --track-origins=yes --vgdb=no /IdeaProjects/Docker-for-debug/project/cmake-build-debug/test

# Add executable
add_executable(test src/main.cpp)