# 基础镜像
FROM fedora:latest
LABEL key="1.0"
ENV TERM=xterm-256color
# 为了避免交互式
ENV AUTO_RUN="true"

RUN dnf update -y && dnf upgrade -y && dnf install -y curl sudo

# 拷贝 init.sh
COPY ./init.sh /tmp/
# 设置执行权限
RUN chmod +x /tmp/init.sh

RUN /tmp/init.sh
