#
# face image
#

# Pull base image.
# FROM ubuntu:16.04
FROM registry.cn-hangzhou.aliyuncs.com/ibbd/cuda:cuda90-cudnn7-py36-ubuntu1604

# install opencv, mxnet
# opencv依赖：
# ImportError: libgthread-2.0.so.0
# ImportError: libSM.so.6
# ImportError: libXrender.so.1
RUN apt-get update -y \
    && apt-get install -y \
        libglib2.0-0 \
        libsm6 \
        libxrender1 \
    && pip install \
        numpy \
        scikit-learn \
        scikit-image \
        opencv-python \
        opencv-contrib-python \
        mxnet-cu90 \
        imutils
        
# 安装 DLIB
RUN apt-get update -y \
    && apt-get install -y git cmake \
    && cd /root/ \
    && git clone https://github.com/davisking/dlib.git \
    && cd /root/dlib \
    && python3 setup.py install \
    && cd .. \
    && rm -r dlib
