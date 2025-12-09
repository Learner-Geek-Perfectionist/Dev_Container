#!/bin/bash
docker start ubuntu_test && docker exec -it -e TERM=xterm-256color ubuntu_test /bin/zsh
