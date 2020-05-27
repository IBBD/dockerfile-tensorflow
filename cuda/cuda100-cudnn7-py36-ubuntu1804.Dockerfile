#
# 安装基础包及工具
# cuda10.0 cudnn7 python3.6 ubuntu18.04 fastapi Dockerfile
# 

# Pull base image.
FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04

MAINTAINER Alex Cai "cyy0523xc@gmail.com"
ENV DEBIAN_FRONTEND noninteractive

# 安装Python3.6, pip, git等
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        git \
        wget \
        python3 \
        python3-dev \
    && wget https://bootstrap.pypa.io/get-pip.py \
    && python3 get-pip.py \
    && rm get-pip.py \
    && rm -rf /var/lib/apt/lists/*

# 安装基础库
RUN pip install -U setuptools \
    && pip --no-cache-dir install \
        numpy \
        scipy \
        scikit-learn \
        matplotlib \
        fastapi \
        uvicorn \
        python-multipart

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：
# terminal is not fully functional
ENV LANG C.UTF-8
ENV TERM xterm
ENV PYTHONIOENCODING utf-8
# 解决时区问题
ENV TZ "Asia/Shanghai"