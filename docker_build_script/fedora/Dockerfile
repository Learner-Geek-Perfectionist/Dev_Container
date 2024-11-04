# 基础镜像
FROM fedora:latest

LABEL key="1.0"

RUN  sed -i '/tsflags=nodocs/s/^/#/' /etc/dnf/dnf.conf

# 设置中科大镜像
RUN sed -e 's|^metalink=|#metalink=|g' \
         -e 's|^#baseurl=http://download.example/pub/fedora/linux|baseurl=https://mirrors.ustc.edu.cn/fedora|g' \
         -i.bak \
         /etc/yum.repos.d/fedora.repo \
         /etc/yum.repos.d/fedora-updates.repo


# 预先生成和存储软件包元数据
RUN dnf makecache


# 更新软件包列表、安装软件包，并清理缓存，所有这些操作都在一个 RUN 指令中完成
RUN dnf update -y && dnf install -y \
    glibc \
    glibc-common \
    openssh-server \
    iproute \
    net-tools \
    fd-find \
    git \
    unzip \
    zip \
    ripgrep \
    fastfetch \
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
    tree \
    coreutils \
    zsh \
    fontconfig \
    python3 \
    wget \
    pkgconf-pkg-config \
    graphviz \
    wireshark \
    tcpdump \
    java-latest-openjdk \
    golang \
    rust \
    man \
    man-pages \
    man-db \
    glibc-locale-source \
    glibc-langpack-zh \
    openssl && \
    dnf group install -y --skip-unavailable "c-development" && \
    dnf clean all


# 设置时区：
RUN ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone

# 设置语言环境：
ENV LANG=zh_CN.UTF-8
ENV LC_ALL=zh_CN.UTF-8
RUN localedef -c -f UTF-8 -i zh_CN zh_CN.UTF-8


# 安装 Kotlin/Native
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



# 复制文件到 root 用户的家目录
# 1.浅克隆仓库到临时目录
RUN git clone --depth 1 https://github.com/Learner-Geek-Perfectionist/Dotfiles /tmp/dotfiles

# 2.复制所需文件到 /root 目录
RUN cp /tmp/dotfiles/.zprofile /root/.zprofile && \
    cp /tmp/dotfiles/.zshrc /root/.zshrc && \
    cp -r /tmp/dotfiles/.config /root/.config

# 3.清理临时文件
RUN rm -rf /tmp/dotfiles

RUN dnf install -y coreutils-common
# 生成和更新手册页的数据库
RUN mandb


# 安装 docker
# 1.下载Docker安装脚本
RUN curl -fsSL https://get.docker.com -o get-docker.sh
# 2.执行下载的安装脚本
RUN sh get-docker.sh



# 安装 SDKMAN 和 kotlin
RUN curl -s "https://get.sdkman.io" | bash \
    && bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && sdk install kotlin"




# 设置容器启动时默认执行 zsh
CMD ["zsh"]
