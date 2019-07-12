#
# cuda10.0 cudnn7 python3.5 ubuntu16.04 Dockerfile
#

# Pull base image.
FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# 安装Python3.5, pip, git等
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        wget \
        python3 \
        python3-dev \
    && wget https://bootstrap.pypa.io/get-pip.py \
    && python3 get-pip.py \
    && rm get-pip.py \
    && rm -rf /var/lib/apt/lists/*

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV LANG C.UTF-8
ENV TERM xterm
ENV PYTHONIOENCODING utf-8
# 解决时区问题
ENV TZ "Asia/Shanghai"
