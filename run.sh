echo "Stop and remove Docker container..."
docker stop opensuse_test > /dev/null 2>&1
docker rm -v -f opensuse_test > /dev/null 2>&1

echo "Build and run Docker container..."

# pwd 的路径取决于执行 run.sh 的路径
docker run -it \
  --name opensuse_test \
  -v "$(pwd)":/project \
  test \
  /bin/bash