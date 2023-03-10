#
# gpu Dockerfile
#

# 使用runtime报错：
# Error: Failed to find dynamic library: libcublas.so
# FROM registry.cn-hangzhou.aliyuncs.com/ibbd/cuda:cuda102-cudnn7-runtime-py36-ubuntu1804
# FROM registry.cn-hangzhou.aliyuncs.com/ibbd/cuda:cuda102-cudnn7-py36-ubuntu1804
# FROM registry.cn-hangzhou.aliyuncs.com/ibbd/cuda:cuda118-py38-u2004
FROM nvidia/cuda:11.7.1-cudnn8-runtime-ubuntu22.04

MAINTAINER Alex Cai "cyy0523xc@gmail.com"
ENV DEBIAN_FRONTEND noninteractive

# 安装Python3.8, pip, git等
# 因为不需要更新nvidia，可以去掉，避免报错
RUN rm -rf /etc/apt/sources.list.d/ \
    && mkdir /etc/apt/sources.list.d/ \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
        git \
        wget \
        curl \
        python3 \
        python3-dev \
    && wget https://bootstrap.pypa.io/get-pip.py \
    && python3 get-pip.py \
    && rm get-pip.py \
    && rm -rf /var/lib/apt/lists/*

# 安装依赖软件
# install tesseract
# opencv依赖：libglib2.0-0, libsm6, libxext-dev
#        curl \
#        build-essential \
#        tesseract-ocr \
#        tesseract-ocr-chi-sim \
#        tesseract-ocr-chi-tra \
# opencv4.4 报错：(切换回4.3还是会报错)
# ImportError: libGL.so.1: cannot open shared object file: No such file or directory
# 需要安装：libgl1-mesa-glx
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        libglib2.0-0 libsm6 libxext-dev libxrender1 libgl1-mesa-glx \
    && rm -rf /var/lib/apt/lists/*

# 阿里云的源是比较快的
# RUN pip3 config set global.index-url https://mirrors.aliyun.com/pypi/simple/
# RUN pip3 config set global.index-url http://mirrors.cloud.tencent.com/pypi/simple
# RUN pip3 config set global.index-url http://pypi.douban.com/simple/
# RUN pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

# 安装基础库
# 约830M
# EasyDict可以让你像访问属性一样访问dict里的变量
# LMDB文件可以同时由多个进程打开，具有极高的数据存取速度，访问简单，不需要运行单独的数据库管理进程，只要在访问数据的代码里引用LMDB库，访问时给文件路径即可。
# h5py: 操作HDF5
# HDF5 拥有一系列的优异特性，使其特别适合进行大量科学数据的存储和操作，如它支持非常多的数据类型，灵活，通用，跨平台，可扩展，高效的 I/O 性能，支持几乎无限量（高达 EB）的单文件存储等
# lxml是处理XML和HTML的python语言
# bs4: Beautiful Soup是python的一个HTML或XML的解析库，我们可以用它来方便的从网页中提取数据
#        opencv-contrib-python==3.4.2.16 \
#        tensorflow==1.14 \
#        tensorflow-gpu==1.14 \
#        keras \
#        Cython \
#        h5py \
#        lmdb \
#        lxml \
#        bs4 \
#        pytesseract \
#        scikit-image \
#        torch torchvision \
RUN pip3 --no-cache-dir install \
        numpy \
        pandas \
        easydict \
        pillow \
        scikit-learn \
        scipy \
        opencv-python \
        fastapi \
        uvicorn \
        python-multipart \
        pyclipper \
        shapely \
        torch torchvision \
        networkx \
    && python3 -c "import cv2"

# 安装ibbd相关的基础模块
RUN pip3 install -r https://github.com/ibbd-dev/python-ibbd-algo/raw/master/requirements.txt \
    && pip3 install git+https://github.com/ibbd-dev/python-ibbd-algo.git \
    && pip3 install -r https://github.com/ibbd-dev/python-image-utils/raw/master/requirements.txt \
    && pip3 install git+https://github.com/ibbd-dev/python-image-utils.git

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：
# terminal is not fully functional
ENV LANG C.UTF-8
ENV TERM xterm
ENV PYTHONIOENCODING utf-8
# 解决时区问题
ENV TZ "Asia/Shanghai"
