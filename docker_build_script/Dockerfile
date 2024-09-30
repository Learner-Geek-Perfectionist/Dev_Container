# 基础镜像
FROM fedora:latest

LABEL key="1.0"

# 设置环境变量
ENV Server_USER="oyzx" \
    TZ=Asia/Shanghai \
    Client_USER="ouyangzhaoxin"



# 设置时区
RUN echo $TZ > /etc/timezone && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime

# 安装必要的软件
RUN dnf update -y && \
    dnf install -y \
    sudo \
    gdb \
    @"C Development Tools and Libraries" \
    cmake \
    git \
    openssh-server \
    pkg-config \
    valgrind \
    systemd \
    iproute \
    net-tools \
    make \
    vim \
    neovim \
    procps-ng \
    fastfetch && \
    dnf clean all

# 设置 root 密码，创建用户，并设置 sudo 无需密码
RUN echo 'root:1' | chpasswd && \
    useradd -m $Server_USER && \
    echo "$Server_USER:1" | chpasswd && \
    usermod -aG wheel $Server_USER && \
    echo "$Server_USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# 配置 SSH 服务
RUN ssh-keygen -A && \
    echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config && \
    echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config