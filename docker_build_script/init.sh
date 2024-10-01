#!/bin/bash

# 设置项目目录权限
chmod -R 777 /home/oyzx/project

# 创建 SSH 目录
mkdir -p /home/oyzx/.ssh /root/.ssh

# 配置免密登录
cp /tmp/id_ed25519.pub /home/oyzx/.ssh/authorized_keys
cp /tmp/id_ed25519.pub /root/.ssh/authorized_keys

# 设置权限
chmod 700 /home/oyzx/.ssh /root/.ssh
chmod 600 /home/oyzx/.ssh/authorized_keys /root/.ssh/authorized_keys

# 更改文件所有权
chown oyzx:oyzx /home/oyzx/.ssh /home/oyzx/.ssh/authorized_keys
chown root:root /root/.ssh /root/.ssh/authorized_keys

# 允许 root 登录
echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config

# 启动 SSH 服务
/usr/sbin/sshd -D -p 2222 &

# 保持容器开启状态
exec /bin/bash