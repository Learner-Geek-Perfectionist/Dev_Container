# 使用 Ubuntu 最新的 LTS 版本作为基础镜像
FROM ubuntu:latest
# FROM ubuntu:20.04
ENV TERM=xterm-256color
ENV DEBIAN_FRONTEND=noninteractive TZ=Asia/Shanghai
RUN set -eux; \
    # 先写时区，再装 tzdata，避免交互
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime; \
    echo "$TZ" > /etc/timezone; \
    apt-get update; \
    apt-get install -y --no-install-recommends tzdata; \
    dpkg-reconfigure -f noninteractive tzdata; \
    rm -rf /var/lib/apt/lists/*


# 为了避免交互式
ENV AUTO_RUN="true"
# 禁用 zsh 全局 compinit，避免生成 .zcompdump
ENV skip_global_compinit=1
# 设置标签
LABEL key="1.0"
RUN apt update && apt upgrade -y && apt install -y curl sudo zsh git fd-find fswatch
RUN alias fd='fdfind -g -HIia -E /System/Volumes/Data -E '.Trash''
# 拷贝 init.sh
COPY ./init.sh /tmp/
# 设置执行权限
RUN chmod +x /tmp/init.sh

RUN /tmp/init.sh
