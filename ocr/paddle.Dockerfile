#
# gpu Dockerfile
#

# Pull base image.
FROM registry.cn-hangzhou.aliyuncs.com/ibbd/cuda:cuda102-cudnn7-py36-ubuntu1804

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# 安装git等
RUN apt-get update -y \
    && apt-get install -y build-essential \
        libglib2.0-0 libsm6 libxrender1 libgl1-mesa-glx \
        curl \
    && rm -rf /var/lib/apt/lists/*

# 安装基础库
RUN pip3 --no-cache-dir install \
        numpy \
        easydict \
        opencv-python \
        h5py \
        lmdb \
        lxml \
        bs4

# install paddle
# 如果使用海外机器构建就不要加国内的源
RUN pip3 install paddlepaddle-gpu -i https://mirror.baidu.com/pypi/simple \
    && pip3 install paddleocr -i https://mirror.baidu.com/pypi/simple

# 安装依赖软件
# install tesseract
# tesseract version: 4.1.1
        # libglib2.0-0 libsm6 libxext-dev libxrender1 libgl1-mesa-glx \
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        tesseract-ocr \
        tesseract-ocr-chi-sim \
        tesseract-ocr-chi-tra \
        ethtool net-tools \
    && rm -rf /var/lib/apt/lists/*

# add ocr file
COPY ./chi_sim_best.traineddata /usr/share/tesseract-ocr/4.00/tessdata/chi_sim_best.traineddata

# 安装ibbd相关的基础模块
RUN pip3 install -r https://github.com/ibbd-dev/python-ibbd-algo/raw/master/requirements.txt \
    && pip3 install git+https://github.com/ibbd-dev/python-ibbd-algo.git \
    && pip3 install -r https://github.com/ibbd-dev/python-image-utils/raw/master/requirements.txt \
    && pip3 install git+https://github.com/ibbd-dev/python-image-utils.git
