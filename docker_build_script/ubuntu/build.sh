# 构建 fedora 镜像
docker build -f Dockerfile -t ubuntu . 2>&1 | tee build.log
