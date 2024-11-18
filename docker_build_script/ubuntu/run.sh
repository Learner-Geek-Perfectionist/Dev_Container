#!/bin/bash
# 删除同名的容器
echo "Stop and remove Docker container..."

docker stop ubuntu_test > /dev/null 2>&1
docker rm -v -f ubuntu_test > /dev/null 2>&1

echo "Build and run Docker container..."

# 获取 run.sh 目录的上两级目录
export PROJECT_DIR=$(dirname $(dirname $(pwd)))

# 运行容器，并将项目 project 目录映射到容器中的 ~/project，并赋予读写权限
docker run -it \
  --name ubuntu_test \
  --net=host \
  -v "${PROJECT_DIR}/project":/root/project \
  ubuntu \
