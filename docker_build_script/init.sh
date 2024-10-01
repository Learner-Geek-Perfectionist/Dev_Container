#!/bin/bash


# 设置环境变量
export Server_USER="oyzx"

# 设置项目目录权限
chmod -R 777 /home/$Server_USER/project

# 创建 SSH 目录
mkdir -p /home/$Server_USER/.ssh /root/.ssh

# 配置免密登录
cp /tmp/id_ed25519.pub /home/$Server_USER/.ssh/authorized_keys
cp /tmp/id_ed25519.pub /root/.ssh/authorized_keys

# 设置权限。注意，这里不能设置为 777，权限过于宽松。
chmod -R 600 /home/$Server_USER/.ssh /root/.ssh
chmod -R 700 /home/$Server_USER/.ssh/authorized_keys /root/.ssh/authorized_keys

# 更改文件所有权
chown $Server_USER:$Server_USER /home/$Server_USER/.ssh /home/$Server_USER/.ssh/authorized_keys
chown root:root /root/.ssh /root/.ssh/authorized_keys


# 启动 SSH 服务
/usr/sbin/sshd -D -p 2222 &

# 切换到用户 oyzx ，并以交互方式启动 bash
exec /bin/bash -c "su oyzx"