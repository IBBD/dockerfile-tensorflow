#!/bin/bash
# 
# 
# Author: alex
# Created Time: 2019年03月13日 星期三 10时49分08秒

sudo docker run --rm --runtime=nvidia -ti --name=ibbd-face \
    -w /face/insightface \
    -v "$PWD"/models:/face/insightface/models \
    "$1" /bin/bash
