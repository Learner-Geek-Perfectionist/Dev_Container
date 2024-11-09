# 基础镜像
FROM fedora:latest

LABEL key="1.0"

# 注释 tsflags=nodocs, 从而安装 manual 手册
RUN  sed -i '/tsflags=nodocs/s/^/#/' /etc/dnf/dnf.conf

# 设置中科大镜像
RUN sed -e 's|^metalink=|#metalink=|g' \
         -e 's|^#baseurl=http://download.example/pub/fedora/linux|baseurl=https://mirrors.ustc.edu.cn/fedora|g' \
         -i.bak \
         /etc/yum.repos.d/fedora.repo \
         /etc/yum.repos.d/fedora-updates.repo

# 更新软件包列表、安装软件包，并清理缓存，所有这些操作都在一个 RUN 指令中完成
RUN dnf -y update && \
    dnf install -y \
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
    glibc-locale-source \
    glibc-langpack-zh \
    jq \
    openssl && \
    dnf install -y --setopt=tsflags= coreutils coreutils-common man-pages man-db && \
    dnf group install -y --setopt=strict=0 "c-development" && \
    dnf clean all && \
    dnf makecache


# 设置时区：
RUN ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone

# 设置语言环境：
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

# 检查是否已安装 Kotlin/Native 和 URL 是否有效，如果有效则下载和解压，否则跳过
RUN if [ -z "${DOWNLOAD_URL+x}" ]; then \
        echo "No download URL set for this architecture, skipping download."; \
    elif [ ! -d "/opt/kotlin-native" ]; then \
        HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$DOWNLOAD_URL") && \
        if [ "$HTTP_STATUS" -ge 200 ] && [ "$HTTP_STATUS" -lt 300 ]; then \
            echo "Downloading and installing Kotlin/Native..."; \
            curl -sL "$DOWNLOAD_URL" -o /tmp/kotlin_native.tar.gz && \
            tar -xzf /tmp/kotlin_native.tar.gz -C /opt --strip-components=1 && \
            rm /tmp/kotlin_native.tar.gz; \
        else \
            echo "Download URL is not valid ($HTTP_STATUS), skipping installation."; \
        fi; \
    else \
        echo "Kotlin/Native already installed at /opt/kotlin-native, skipping download and installation."; \
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




# 安装 SDKMAN 和 kotlin
RUN curl -s "https://get.sdkman.io" | bash \
    && bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && sdk install kotlin"

# 确保安装必要的 manual 手册
RUN dnf -y reinstall $(rpm -qads --qf "PACKAGE: %{NAME}\n" | sed -n -E '/PACKAGE: /{s/PACKAGE: // ; h ; b }; /^not installed/ { g; p }' | uniq)

# 生成和更新手册页的数据库
RUN mandb -c


# 设置容器启动时默认执行 zsh
CMD ["zsh"]
