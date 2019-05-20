#!/bin/bash
# 
# 
# Author: alex
# Created Time: 2019年04月26日 星期五 10时50分41秒

#-v $HOME/notebook/work:/home/jovyan/work \
# TODO 本应该挂载一个数据目录到work的，但是挂载这个目录时候，在容器里的权限就出现读写问题
# 容器里面的用户是jovyan
# 没有外部目录的话，容器删除就会丢数据
docker run -u $(id -u):$(id -g) -d --restart always --name ibbd-notebook \
    -p 8888:8888 \
    -e JUPYTER_ENABLE_LAB=yes \
    -v `pwd`/jupyter_notebook_config.py:/home/jovyan/.jupyter/jupyter_notebook_config.py \
    registry.cn-hangzhou.aliyuncs.com/ibbd/notebook 
