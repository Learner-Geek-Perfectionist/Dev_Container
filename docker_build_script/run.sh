# 设置环境变量
export Server_USER="oyzx"
export Client_USER="ouyangzhaoxin"

# 删除同名的容器
echo "Stop and remove Docker container..."

docker stop fedora_test > /dev/null 2>&1
docker rm -v -f fedora_test > /dev/null 2>&1

echo "Build and run Docker container..."

# 获取上一级目录的绝对路径
PARENT_DIR="$(cd .. && pwd)"

# 给 init.sh 添加权限
chmod +x $PARENT_DIR/docker_build_script/init.sh

# 运行容器，并将项目 project 目录映射到容器中的 ～/project，并赋予读写权限
# 容器的 ssh 服务的监听端口设置为 2222 ，使用 ssh -p 2222 oyzx@localhost 远程连接 docker 容器
# 添加「客户端公钥」，实现 ssh 免密登陆。
docker run -it \
  --name fedora_test \
  --net=host \
  -v "$PARENT_DIR/project":/home/$Server_USER/project \
  fedora \
  /bin/bash
