# Pull base image.
FROM registry.cn-hangzhou.aliyuncs.com/ibbd/cuda:cuda100-cudnn7-py36-ubuntu1604

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# 安装基础库, opencv
RUN apt-get update -y \
    && apt-get install -y \
        libglib2.0-0 \
        libsm6 \
        libxrender1 \
    && python3 -m pip install -U setuptools \
    && python3 -m pip --no-cache-dir install \
        numpy \
        pandas \
        scipy \
        scikit-learn \
        opencv-python \
        opencv-contrib-python==3.4.2.16 
        
# 安装 DLIB
RUN apt-get update -y \
    && apt-get install -y git cmake libboost-all-dev libx11-dev \
    && cd /root/ \
    && git clone https://github.com/davisking/dlib.git \
    && cd /root/dlib \
    && python3 setup.py install \
    && cd .. \
    && rm -r dlib
