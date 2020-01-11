#
# gpu Dockerfile
#

# Pull base image.
# FROM registry.cn-hangzhou.aliyuncs.com/ibbd/cuda:cuda90-cudnn7-py36-ubuntu1604
FROM registry.cn-hangzhou.aliyuncs.com/ibbd/cuda:cuda101-cudnn7-py36-ubuntu1804

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# 安装git等
# install tesseract
# opencv依赖：libglib2.0-0, libsm6
RUN apt-get update -y \
    && apt-get install -y build-essential \
        libglib2.0-0 libsm6 libxrender1 \
        git \
        curl \
        tesseract-ocr \
        tesseract-ocr-chi-sim \
        tesseract-ocr-chi-tra \
    && rm -rf /var/lib/apt/lists/*

# 安装基础库
        # opencv-contrib-python==3.4.2.16 \
RUN pip --no-cache-dir install \
        numpy \
        pandas \
        easydict \
        Cython \
        opencv-python \
        h5py \
        lmdb \
        lxml \
        bs4 \
        tensorflow==1.8 \
        tensorflow-gpu==1.8 \
        keras==2.1.5 \
        torch torchvision \
        pytesseract

RUN cd / \
    && git clone https://github.com/zergmk2/darknet.git \
    && cd darknet/ \
    && make 

# 安装server服务相关
RUN pip3 install -r https://github.com/ibbd-dev/python-fire-rest/raw/master/requirements.txt \
    && pip3 install git+https://github.com/ibbd-dev/python-fire-rest.git
