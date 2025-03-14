#!/bin/bash

# 删除同名的容器
echo "Stop and remove Docker container..."

docker stop fedora_test > /dev/null 2>&1
docker rm -v -f fedora_test > /dev/null 2>&1

echo "Build and run Docker container..."

# 获取 run.sh 目录的上两级目录
export PROJECT_DIR=$(dirname $(dirname $(pwd)))

# 给 init.sh 添加权限
# chmod +x $PARENT_DIR/docker_build_script/init.sh

# 运行容器，并将项目 project 目录映射到容器中的 ~/project，并赋予读写权限
docker run -it \
  --name fedora_test \
  --net=host \
  -v "${PROJECT_DIR}/project":/root/project \
  fedora \
  /bin/zsh
