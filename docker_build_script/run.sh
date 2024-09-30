echo "Stop and remove Docker container..."
docker stop fedora_test > /dev/null 2>&1
docker rm -v -f fedora_test > /dev/null 2>&1

echo "Build and run Docker container..."

# 获取上一级目录的绝对路径
PARENT_DIR="$(cd .. && pwd)"

# 运行容器，并将项目 project 目录映射到容器中的 ～/project，并赋予读写权限
# 容器的 ssh 服务的监听端口设置为 2222 ，使用 ssh -p 2222 oyzx@localhost 远程连接 docker 容器

echo "Stop and remove Docker container..."
docker stop fedora_test > /dev/null 2>&1
docker rm -v -f fedora_test > /dev/null 2>&1

echo "Build and run Docker container..."

# 获取上一级目录的绝对路径
PARENT_DIR="$(cd .. && pwd)"

# 运行容器，并将项目 project 目录映射到容器中的 ～/project，并赋予读写权限
# 容器的 ssh 服务的监听端口设置为 2222 ，使用 ssh -p 2222 oyzx@localhost 远程连接 docker 容器
# 添加公钥，实现 ssh 免密登陆
docker run -it \
  --name fedora_test \
  --net=host \
  -v "$PARENT_DIR/project":/home/oyzx/project \
  -v "/Users/ouyangzhaoxin/.ssh/id_ed25519.pub:/home/oyzx/.ssh/authorized_keys" \
  fedora \
  /bin/bash -c "\
    chmod -R 775 /home/oyzx/project && \
    chmod 600 /home/oyzx/.ssh/authorized_keys && \
    chown oyzx:oyzx /home/oyzx/.ssh/authorized_keys && \
    /usr/sbin/sshd -D -p 2222 & \
    exec /bin/bash"