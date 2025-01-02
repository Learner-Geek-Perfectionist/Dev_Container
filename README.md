```shell
 git clone --depth 1 git@github.com:Learner-Geek-Perfectionist/Dev_Container.git
```

# Container Development Environment
# 删除所有 Docker 相关的内容

```shell
docker stop $(docker ps -aq); docker rm -f $(docker ps -aq); docker system prune -a --volumes --force; docker builder prune --all --force
```

## Directory Structure
Below is the directory structure of the repository, providing a clear view of the components and their organization:

``` markdown
Dev_Container
├── .devcontainer
│   ├── Dockerfile
│   └── devcontainer.json
├── README.md
├── docker_build_script
│   ├── fedora
│   │   ├── Dockerfile
│   │   ├── build.sh
│   │   ├── init.sh
│   │   └── run.sh
│   └── ubuntu
│       ├── Dockerfile
│       ├── build.sh
│       ├── init.sh
│       └── run.sh
└── project
    ├── CMakeLists.txt
    └── src
        └── main.cpp
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
