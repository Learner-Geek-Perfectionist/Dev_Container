# Container Development Environment

## Directory Structure
Below is the directory structure of the repository, providing a clear view of the components and their organization:

``` markdown
Dev_Container
├── README.md
├── cmake-build-debug
│   ├── CMakeCache.txt
│   ├── CMakeFiles
│   │   ├── Makefile
│   │   ├── Testing
│   │   └── build.ninja
│   ├── cmake_install.cmake
│   ├── test
│   │   ├── test.cbp
│   │   └── test.exe
│   └── test.cbp
├── docker_build_script
│   ├── Dockerfile
│   ├── build.sh
│   └── run.sh
├── project
│   ├── CMakeLists.txt
│   ├── cmake-build-debug
│   │   └── src
│   └── src
└── valgrind_output.log
```


## Introduction
This repository offers a flexible Linux-based development environment within Docker containers. Our setup utilizes Fedora as the base image, providing robust support for various development needs.

## Setup Options
You have two primary methods to configure your development environment:

- **Manual Construction**: Use scripts in the `docker_build_script` directory to manually build your Docker containers.
- **JetBrains Gateway Integration**: For a seamless development experience, use JetBrains Gateway to manage development containers located in the `.devcontainer` directory.

## Memory Leak Testing
The `project` directory contains a CMake project tailored for conducting memory leak tests in Linux environments using Valgrind. This is essential for developers aiming to optimize their applications and ensure they are free from memory leaks.

## Configuration Details
Please adjust the `source` path in the `mounts` keyword within the `devcontainer.json` file found in the `.devcontainer` directory. This change is crucial for correctly mapping your development environment to your local system.

## Getting Started
To begin with the manual Docker setup, navigate to the `docker_build_script` directory and follow the provided scripts to build your environment. If opting for JetBrains Gateway, ensure your `devcontainer.json` is properly configured before starting your development sessions.

## Contributing
Contributions to improve the development environment are welcomed. Please feel free to fork the repository, make your changes, and submit a pull request. For bugs or suggestions, open an issue in the GitHub repository.
