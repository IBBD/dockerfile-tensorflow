#!/bin/bash
# 
# 
# Author: alex
# Created Time: 2019年04月26日 星期五 10时50分41秒

    #-v $HOME/notebook/work:/home/jovyan/work \
docker run -d --restart always --name ibbd-notebook \
    -p 8888:8888 \
    -e JUPYTER_ENABLE_LAB=yes \
    -v `pwd`/jupyter_notebook_config.py:/home/jovyan/.jupyter/jupyter_notebook_config.py \
    registry.cn-hangzhou.aliyuncs.com/ibbd/notebook 
