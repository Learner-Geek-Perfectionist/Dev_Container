# 使用 Ubuntu 最新的 LTS 版本作为基础镜像
FROM ubuntu:latest

# 设置标签
LABEL key="1.0"

# 设置非交互式安装模式，避免在构建过程中出现提示
ENV DEBIAN_FRONTEND=noninteractive

# 设置时区环境变量
ENV TZ=Asia/Shanghai

# 安装 tzdata 包并设置时区
RUN apt-get update && apt-get install -y tzdata \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    && dpkg-reconfigure --frontend noninteractive tzdata

# 设置中科大镜像为 Ubuntu 源
RUN sed -i.bak -e 's|http://archive.ubuntu.com/ubuntu/|https://mirrors.ustc.edu.cn/ubuntu/|g' \
               -e 's|http://security.ubuntu.com/ubuntu|https://mirrors.ustc.edu.cn/ubuntu|g' \
               /etc/apt/sources.list

# 复制文件到 root 用户的家目录
COPY /.zprofile /root/
COPY /.zshrc /root/
COPY /.config /root/.config

# 安装依赖的软件包
RUN apt-get update && apt-get install -y \
    openssh-server \
    net-tools \
    git \
    unzip \
    ninja-build \
    neovim \
    ruby-full \
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
    kotlin \
    golang \
    zip \
    software-properties-common \
    valgrind \
    curl \
    tar \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 安装 fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf \
    && yes | ~/.fzf/install --no-update-rc

# 安装 Kotlin/Native
RUN ARCH=$(uname -m) && \
    LATEST_VERSION=$(curl -s -L -I https://github.com/JetBrains/kotlin/releases/latest | grep -i location | sed -E 's/.*tag\/(v[0-9\.]+).*/\1/') && \
    if [ "$ARCH" == "x86_64" ]; then \
        DOWNLOAD_URL="https://github.com/JetBrains/kotlin/releases/download/$LATEST_VERSION/kotlin-native-prebuilt-linux-x86_64-${LATEST_VERSION#v}.tar.gz"; \
        INSTALL_DIR="/opt/kotlin-native-linux-x86_64-$LATEST_VERSION"; \
    elif [ "$ARCH" == "aarch64" ]; then \
        DOWNLOAD_URL="https://github.com/JetBrains/kotlin/releases/download/$LATEST_VERSION/kotlin-native-prebuilt-linux-aarch64-${LATEST_VERSION#v}.tar.gz"; \
        INSTALL_DIR="/opt/kotlin-native-linux-aarch64-$LATEST_VERSION"; \
    else \
        echo "Unsupported Linux architecture: $ARCH" && exit 1; \
    fi && \
    (curl -s -o /dev/null -w "%{http_code}" "$DOWNLOAD_URL" | grep -q "200") && \
    mkdir -p "$INSTALL_DIR" && \
    curl -sL "$DOWNLOAD_URL" -o kotlin_native.tar.gz && \
    tar -xzf kotlin_native.tar.gz -C "$INSTALL_DIR" --strip-components=1 && \
    rm kotlin_native.tar.gz


RUN ARCH=$(uname -m) && \
    LATEST_VERSION=$(curl -s -L -I https://github.com/JetBrains/kotlin/releases/latest | grep -i location | sed -E 's/.*tag\/(v[0-9\.]+).*/\1/')

RUN #echo "最新版本是 $LATEST_VERSION"




# 安装 SDKMAN 和 Java
RUN curl -s "https://get.sdkman.io" | bash \
    && bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && sdk install java"

# 设置容器启动时默认执行 zsh
CMD ["zsh"]

