# 基础镜像
FROM fedora:latest

LABEL key="1.0"


COPY ./init.sh /tmp/
# 设置执行权限
RUN chmod +x /tmp/init.sh

RUN /tmp/init.sh
