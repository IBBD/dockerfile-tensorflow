#
# face image
#

# Pull base image.
# FROM ubuntu:16.04
FROM nvidia/cuda:9.0-cudnn7-runtime-ubuntu16.04

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# install base
# opencv依赖：
# ImportError: libgthread-2.0.so.0
# ImportError: libSM.so.6
# ImportError: libXrender.so.1
RUN apt-get update -y \
    && apt-get install -y \
        wget \
        python3 python-dev \
        gcc \
        git \
        libglib2.0-0 \
        libsm6 \
        libxrender1 \
    && wget https://bootstrap.pypa.io/get-pip.py \
    && python3 get-pip.py \
    && rm get-pip.py

# pip install
# mxnet
RUN pip3 install \
        scipy \
        easydict \
        scikit-learn \
        scikit-image \
        opencv-python \
        opencv-contrib-python \
        mxnet-cu90

# 安装server服务相关
RUN pip3 --no-cache-dir install flask flask_restful jsonschema \
    && pip3 install git+https://github.com/ibbd-dev/python-fire-rest.git

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm

# 解决时区问题
ENV TZ "Asia/Shanghai"
