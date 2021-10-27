#
# gpu Dockerfile
# v2: 20210728

# 使用runtime报错：
# Error: Failed to find dynamic library: libcublas.so
FROM registry.cn-hangzhou.aliyuncs.com/ibbd/cuda:cuda102-cudnn7-py38-ubuntu2004-dev

LABEL user="Alex Cai"
LABEL email="cyy0523xc@gmail.com"
LABEL version="2.0"
LABEL description="v2-20210728"

# install paddle
# 约400M
# 20201105: 1.7.2安装失败
# RUN pip3 --no-cache-dir install paddlepaddle-gpu==1.7.2.post107
# RUN pip3 --no-cache-dir install paddlepaddle-gpu==2.0.0b0 -i https://mirror.baidu.com/pypi/simple
# 20210408: 依赖pytest
# RUN pip3 install --no-cache-dir pytest \
#     && pip3 --no-cache-dir install paddlepaddle-gpu==1.8.5.post107
# 20210728: paddle2.0以上
# paddlepaddle_gpu-2.1.1
# paddleocr-2.0.6
RUN pip3 install paddlepaddle-gpu -i https://mirror.baidu.com/pypi/simple \
    && pip3 install paddleocr -i https://mirror.baidu.com/pypi/simple

# 安装依赖软件
# install tesseract
# tesseract version: 4.1.1
# opencv依赖：libglib2.0-0, libsm6, libxext-dev
#        curl \
#        build-essential \
# opencv4.4 报错：
# ImportError: libGL.so.1: cannot open shared object file: No such file or directory
# 需要安装：libgl1-mesa-glx
# ethtool, net-tools: 获取硬件信息时依赖
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        libglib2.0-0 libsm6 libxext-dev libxrender1 libgl1-mesa-glx \
        tesseract-ocr \
        tesseract-ocr-chi-sim \
        tesseract-ocr-chi-tra \
    && rm -rf /var/lib/apt/lists/*

# add ocr file
COPY ./chi_sim_best.traineddata /usr/share/tesseract-ocr/4.00/tessdata/chi_sim_best.traineddata

# 阿里云的源是比较快的
# RUN pip3 config set global.index-url https://mirrors.aliyun.com/pypi/simple/
# RUN pip3 config set global.index-url http://mirrors.cloud.tencent.com/pypi/simple
# RUN pip3 config set global.index-url http://pypi.douban.com/simple/
# RUN pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

# 安装基础库
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
#        torch torchvision \
# 20211027 flashtext: 高效的文本处理工具
RUN pip3 --no-cache-dir install \
        numpy \
        pandas \
        scipy \
        easydict \
        pillow \
        scikit-learn \
        scikit-image \
        opencv-python \
        fastapi uvicorn python-multipart \
        gunicorn uvloop httptools \
        pyclipper \
        shapely \
        pytesseract \
        fuzzywuzzy python-Levenshtein \
        flashtext \
    && python3 -c "import cv2"

# 安装ibbd相关的基础模块
RUN pip3 install -r https://github.com/ibbd-dev/python-ibbd-algo/raw/master/requirements.txt \
    && pip3 install git+https://github.com/ibbd-dev/python-ibbd-algo.git \
    && pip3 install -r https://github.com/ibbd-dev/python-image-utils/raw/master/requirements.txt \
    && pip3 install git+https://github.com/ibbd-dev/python-image-utils.git
