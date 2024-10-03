# 基础镜像
FROM fedora:latest

LABEL key="1.0"



# 设置环境变量
ENV Server_USER="oyzx" \
    TZ=Asia/Shanghai \
    Client_USER="ouyangzhaoxin"

# 设置时区
RUN echo $TZ > /etc/timezone && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime

# 设置中科大镜像
RUN sed -e 's|^metalink=|#metalink=|g' \
         -e 's|^#baseurl=http://download.example/pub/fedora/linux|baseurl=https://mirrors.ustc.edu.cn/fedora|g' \
         -i.bak \
         /etc/yum.repos.d/fedora.repo \
         /etc/yum.repos.d/fedora-updates.repo

RUN dnf makecache

# 安装必要的软件
RUN dnf update -y && \
    dnf install -y  \
    openssh-server \
    iproute \
    net-tools \
    fd-find \
    ripgrep \
    fzf \
    ninja-build \
    neovim \
    ruby \
    kitty \
    cmake \
    nodejs \
    iputils \
    procps-ng \
    htop \
    traceroute \
    fastfetch \
    tree \
    zsh &&\
    dnf group install -y "C Development Tools and Libraries" && \
    dnf clean all



# 设置 root 密码；创建用户 oyzx ；设置用户 oyzx 密码；设置用户 oyzx 无需 sudo 密码。
RUN echo 'root:1' | chpasswd && \
    useradd -m $Server_USER && \
    echo "$Server_USER:1" | chpasswd && \
    usermod -aG wheel $Server_USER && \
    echo "$Server_USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# 在容器中添加 SSH 「密钥」；允许客户端以 root 用户登陆容器
RUN ssh-keygen -A && \
    echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config && \
    echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config
