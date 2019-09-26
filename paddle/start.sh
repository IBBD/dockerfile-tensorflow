#!/bin/bash
# 
# 
# Author: alex
# Created Time: 2019年09月20日 星期五 10时10分43秒
docker run --rm -ti \
    --runtime=nvidia \
    -v $PWD:/data \
    registry.cn-hangzhou.aliyuncs.com/ibbd/paddle:cv \
    /bin/bash
