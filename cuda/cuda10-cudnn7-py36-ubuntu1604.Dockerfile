#
# cuda10.0 cudnn7 python3.6 ubuntu16.04 Dockerfile
#

# Pull base image.
FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# 安装Python3.6, pip, git等
RUN apt-get update -y \
    && apt-get install -y software-properties-common \
    && add-apt-repository ppa:jonathonf/python-3.6 -y \
    && apt-get update -y \
    && apt-get install -y \
        python3.6 python3-pip \
        python3.6-dev \
    && rm /usr/bin/python3 \
    && ln -s /usr/bin/python3.6 /usr/bin/python3 \
    && ln -s /usr/bin/python3.6 /usr/bin/python \
    && pip3 install --upgrade pip \
    && rm /usr/local/bin/pip3 \
    && rm /usr/bin/pip3 \
    && rm -rf /var/lib/apt/lists/*

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm

# 解决时区问题
ENV TZ "Asia/Shanghai"
