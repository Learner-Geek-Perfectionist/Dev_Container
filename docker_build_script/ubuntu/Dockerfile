# 使用 Ubuntu 最新的 LTS 版本作为基础镜像
FROM ubuntu:latest

# 为了避免交互式
ENV AUTO_RUN="true"

# 设置标签
LABEL key="1.0"
RUN apt update -y && apt install -y curl

# 拷贝 init.sh
COPY ./init.sh /tmp/
# 设置执行权限
RUN chmod +x /tmp/init.sh

RUN /tmp/init.sh

# 设置默认的shell为zsh
SHELL ["/bin/zsh", "-c"]
