# 使用 Ubuntu 最新的 LTS 版本作为基础镜像
FROM ubuntu:latest

# 设置标签
LABEL key="1.0"

# 设置非交互式安装模式，避免在构建过程中出现提示
ENV DEBIAN_FRONTEND=noninteractive


# 设置中科大镜像为 Ubuntu 源
RUN sed -i.bak -e 's|http://archive.ubuntu.com/ubuntu/|https://mirrors.ustc.edu.cn/ubuntu/|g' \
               -e 's|http://security.ubuntu.com/ubuntu|https://mirrors.ustc.edu.cn/ubuntu|g' \
               /etc/apt/sources.list

# 安装依赖的软件包
RUN apt update && apt install -y \
    openssh-server \
    debconf-utils \
    net-tools \
    git \
    unzip \
    zip \
    ninja-build \
    neovim \
    ruby-full \
    fd-find \
    ripgrep \
    cmake \
    nodejs \
    iputils-ping \
    procps \
    htop \
    traceroute \
    tree \
    coreutils \
    zsh \
    fontconfig \
    python3 \
    iproute2 \
    kitty \
    wget \
    pkg-config \
    graphviz \
    sudo \
    wireshark \
    tcpdump \
    kotlin \
    golang \
    rustc \
    software-properties-common \
    valgrind \
    curl \
    tar \
    locales \
    unminimize \
    man-db \
    jq \
    && apt clean && rm -rf /var/lib/apt/lists/*


# 执行 unminimize 脚本
RUN yes | unminimize

# 设置时区环境变量
ENV TZ=Asia/Shanghai

# 设置时区
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    && dpkg-reconfigure --frontend noninteractive tzdata

# 生成所需的语言环境
RUN locale-gen zh_CN.UTF-8

# 设置默认的语言环境
ENV LANG=zh_CN.UTF-8
ENV LC_ALL=zh_CN.UTF-8


# 复制文件到 root 用户的家目录
# 1.浅克隆仓库到临时目录
RUN git clone --depth 1 https://github.com/Learner-Geek-Perfectionist/Dotfiles /tmp/dotfiles

# 2.复制所需文件到 /root 目录
RUN cp /tmp/dotfiles/.zprofile /root/.zprofile && \
    cp /tmp/dotfiles/.zshrc /root/.zshrc && \
    cp -r /tmp/dotfiles/.config /root/.config

# 3.清理临时文件
RUN rm -rf /tmp/dotfiles



# 安装 fastfetch
# 1.克隆fastfetch源代码
RUN git clone https://github.com/LinusDierheimer/fastfetch.git /fastfetch

# 2.编译和安装fastfetch
RUN cd /fastfetch && \
    mkdir build && cd build && \
    cmake .. && \
    make && \
    make install && \
    cd / && \
    rm -rf /fastfetch



# 安装 Docker
RUN curl -fsSL https://get.docker.com -o get-docker.sh \
    && sh get-docker.sh \
    && rm get-docker.sh


# 设置 Docker 镜像源
RUN mkdir -p /etc/docker \
    && echo '{ \
      "registry-mirrors": [ \
        "https://docker.m.daocloud.io", \
        "https://mirror.baidubce.com", \
        "http://hub-mirror.c.163.com" \
      ] \
    }' > /etc/docker/daemon.json

# 清理缓存
RUN apt clean && \
    rm -rf /var/lib/apt/lists/*



# 安装 fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf \
    && yes | ~/.fzf/install --no-update-rc



## 安装 Kotlin/Native
# 检测架构并准备下载 URL
RUN ARCH=$(uname -m) && \
    LATEST_VERSION=$(curl -s -L -I https://github.com/JetBrains/kotlin/releases/latest | grep -i location | sed -E 's/.*tag\/(v[0-9\.]+).*/\1/') && \
    if [ "$ARCH" == "x86_64" ]; then \
        DOWNLOAD_URL="https://github.com/JetBrains/kotlin/releases/download/$LATEST_VERSION/kotlin-native-prebuilt-linux-x86_64-${LATEST_VERSION#v}.tar.gz"; \
    elif [ "$ARCH" == "aarch64" ]; then \
        DOWNLOAD_URL="https://github.com/JetBrains/kotlin/releases/download/$LATEST_VERSION/kotlin-native-prebuilt-linux-aarch64-${LATEST_VERSION#v}.tar.gz"; \
    else \
        echo "Unsupported Linux architecture: $ARCH" && exit 0; \
    fi

# 检查 URL 是否有效，如果有效则下载和解压，否则跳过
RUN if [ -z "${DOWNLOAD_URL+x}" ]; then \
        echo "No download URL set for this architecture, skipping download."; \
    elif curl -s -o /dev/null -w "%{http_code}" "$DOWNLOAD_URL" | grep -q "200"; then \
        echo "Downloading and installing Kotlin/Native..."; \
        curl -sL "$DOWNLOAD_URL" -o kotlin_native.tar.gz && \
        tar -xzf kotlin_native.tar.gz -C /opt --strip-components=1 && \
        rm kotlin_native.tar.gz; \
    else \
        echo "Download URL is not valid, skipping installation."; \
    fi





# 安装 SDKMAN 和 Java
RUN curl -s "https://get.sdkman.io" | bash \
    && bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && sdk install java"



# 设置容器启动时默认执行 zsh
CMD ["zsh"]
