# Pull base image.
# FROM mettainnovations/ubuntu-base:16.04-cuda10
FROM registry.cn-hangzhou.aliyuncs.com/ibbd/cuda:cuda101-cudnn7-py36-ubuntu1804

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# 安装基础库, opencv
RUN python3 -m pip install -U setuptools \
    && python3 -m pip --no-cache-dir install \
        numpy \
        pandas \
        scipy \
        scikit-learn \
        opencv-python \
        opencv-contrib-python==3.4.2.16 
        
# 安装 DLIB
RUN apt-get update -y \
    && apt-get install -y git cmake \
    && cd /root/ \
    && git clone https://github.com/davisking/dlib.git \
    && cd /root/dlib \
    && python3 setup.py install \
    && cd .. \
    && rm -r dlib
    
