#!/bin/bash
# 
# 
# Author: alex
# Created Time: 2019年03月13日 星期三 10时49分08秒

sudo docker run --rm --runtime=nvidia -ti \
    -w /face/insightface \
    -v "$PWD"/models:/face/insightface/models \
    registry.cn-hangzhou.aliyuncs.com/ibbd/face:insightface \
    /bin/bash
