#!/bin/bash
# 构建 fedora 镜像
docker build -f Dockerfile -t fedora . 2>&1 | tee build.log
