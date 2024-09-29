# 基础镜像
FROM fedora:latest

LABEL key="1.0"

# 设置时区
ENV TZ=Asia/Shanghai
RUN echo $TZ > /etc/timezone && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime


# 更新系统并安装必要软件
RUN dnf update -y && \
    dnf install -y gdb @'C Development Tools and Libraries' cmake git openssh-server gdb pkg-config valgrind systemd iproute net-tools

# 设置root密码为1
RUN echo 'root:1' | chpasswd

# 配置SSH允许root登录
RUN sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config

# 生成SSH密钥
RUN ssh-keygen -A

# 设置容器启动时运行SSH服务
CMD ["/usr/sbin/sshd", "-D"]

# 暴露端口
EXPOSE 22