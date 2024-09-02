echo "Stop and remove Docker container..."
docker stop fedora_test > /dev/null 2>&1
docker rm -v -f fedora_test > /dev/null 2>&1

echo "Build and run Docker container..."

# 获取上一级目录的绝对路径
PARENT_DIR="$(cd .. && pwd)"

# 运行容器，并将上一级的 project 目录映射到容器中的 /project
docker run -it \
  --name fedora_test \
  -v "$PARENT_DIR/project":/project \
  fedora \
  /bin/bash