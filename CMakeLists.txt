cmake_minimum_required(VERSION 3.28)
project(test)

## Set the C++ standard
set(CMAKE_CXX_STANDARD 17)

# Add compiler and linker flags for AddressSanitizer
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fsanitize=address -g")


# Add executable
add_executable(test src/main.cpp)