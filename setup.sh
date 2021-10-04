#!/usr/bin/env bash
image_version=`date +%Y%m%d%H%M`;
# 关闭FIRSTTEST容器
docker stop FIRSTTEST || true;
# 删除FIRSTTEST容器
docker rm FIRSTTEST || true;
# 删除FIRSTTEST镜像
docker rmi --force $(docker images | grep FIRSTTEST | awk '{print $3}')
# docker rmi first_test;
# 构建first_test:$image_version镜像
docker build -t first_test:$image_version .;
# 查看镜像列表
docker images;
# 基于 first_test 镜像 构建一个容器 first_test
docker run -d --name FIRSTTEST -p 8011:80 first_test:$image_version;
# 查看日志
docker logs FIRSTTEST;
#删除build过程中产生的镜像    #docker image prune -a -f
docker rmi $(docker images -f "dangling=true" -q)
# 对空间进行自动清理
docker system prune -a -f
