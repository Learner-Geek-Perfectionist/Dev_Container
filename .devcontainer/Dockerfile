# 基础镜像
FROM fedora:latest

LABEL key="1.0"

# 下面的命令设置了时区为亚洲/上海（Asia/Shanghai），确保容器在中国的时区中运行。
# ENV TZ=Asia/Shanghai: 设置环境变量 TZ 为 Asia/Shanghai，即将时区设为中国上海时区。
# RUN echo $TZ > /etc/timezone && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime: 将时区值写入 /etc/timezone 文件，并将 /usr/share/zoneinfo/$TZ 软链接到 /etc/localtime，以持久化保存时区设置。
ENV TZ=Asia/Shanghai
RUN echo $TZ > /etc/timezone && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime



# 安装软件包，适用于 Fedora 系统
RUN dnf install -y gdb @'C Development Tools and Libraries' cmake git openssh-server gdb pkg-config valgrind systemd iproute net-tools

# 设置root密码为 1
RUN echo 'root:1' | chpasswd

# 配置SSH允许root登录
RUN sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config

# 生成SSH密钥
RUN ssh-keygen -A

# 设置容器启动时运行SSH服务
CMD ["/usr/sbin/sshd", "-D"]