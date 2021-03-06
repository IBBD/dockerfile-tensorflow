#
# cuda9.0 cudnn7 python3.6 ubuntu16.04 Dockerfile
#

# Pull base image.
FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

MAINTAINER Alex Cai "cyy0523xc@gmail.com"
ENV DEBIAN_FRONTEND noninteractive

# 安装Python3.6, pip, git等
# apt-get install -y libcuda1-384
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends software-properties-common \
    && add-apt-repository ppa:jonathonf/python-3.6 -y \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
        wget \
        python3.6 \
        python3.6-dev \
    && rm -f /usr/bin/python3 \
    && ln -s /usr/bin/python3.6 /usr/bin/python \
    && ln -s /usr/bin/python3.6 /usr/bin/python3 \
    && wget https://bootstrap.pypa.io/get-pip.py \
    && python3 get-pip.py \
    && rm get-pip.py \
    && rm -rf /var/lib/apt/lists/*

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm
ENV PYTHONIOENCODING utf-8

# 解决时区问题
ENV TZ "Asia/Shanghai"
