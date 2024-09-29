echo "Stop and remove Docker container..."
docker stop fedora_test > /dev/null 2>&1
docker rm -v -f fedora_test > /dev/null 2>&1

echo "Build and run Docker container..."

# 获取上一级目录的绝对路径
PARENT_DIR="$(cd .. && pwd)"

# 构建Docker镜像
docker build -t fedora-ssh .

# 运行容器，并将上一级的 project 目录映射到容器中的 /project
# 同时映射SSH端口，这里将容器的22端口映射到主机的2222端口
docker run -it \
  --name fedora_test \
  -v "$PARENT_DIR/project":/project \
  -p 2222:22 \
  fedora-ssh \
  /usr/sbin/sshd -D