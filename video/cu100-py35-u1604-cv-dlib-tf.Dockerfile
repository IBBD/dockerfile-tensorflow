# Pull base image.
FROM registry.cn-hangzhou.aliyuncs.com/ibbd/cuda:cuda100-cudnn7-py35-ubuntu1604

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# 安装基础库, opencv
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        libglib2.0-0 \
        libsm6 \
        libxrender1 \
        libxext-dev \
        pkg-config \
    && pip install -U setuptools \
    && pip --no-cache-dir install \
        numpy \
        pandas \
        scipy \
        scikit-learn \
        matplotlib \
        opencv-python \
        opencv-contrib-python \
        tensorflow-gpu \
        keras \
        pillow

# install dlib
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends git cmake \
    && cd /root/ \
    && git clone https://github.com/davisking/dlib.git \
    && cd /root/dlib \
    && python3 setup.py install \
    && cd .. \
    && rm -r dlib

# 安装服务常用包
RUN python3 -m pip --no-cache-dir install \
        imageio-ffmpeg \
        flask \
        flask_jsonrpc \
        fire \
        jsonschema \
        flask_restful \
    && python3 -m pip install git+https://github.com/ibbd-dev/python-fire-rest.git 
