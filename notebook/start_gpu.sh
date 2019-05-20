#!/bin/bash
# 
# 
# Author: alex
# Created Time: 2019年05月20日 星期一 14时22分00秒
sudo docker rm -f ibbd-notebook
sudo docker run -u $(id -u):$(id -g) -d --restart always \
    --name ibbd-notebook \
    --runtime=nvidia \
    -p 8888:8888 \
    -e JUPYTER_ENABLE_LAB=yes \
    -v `pwd`/work:/tf \
    -v `pwd`/jupyter_notebook_config.py:/.jupyter/jupyter_notebook_config.py \
    registry.cn-hangzhou.aliyuncs.com/ibbd/notebook:gpu
