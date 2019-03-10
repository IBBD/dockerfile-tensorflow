#
# gpu Dockerfile
#

# Pull base image.
# FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04
# FROM registry.cn-hangzhou.aliyuncs.com/ibbd/ocr:cuda10-cudnn7-py36-ubuntu1604
FROM registry-internal.cn-hangzhou.aliyuncs.com/ibbd/ocr:cuda10-cudnn7-py36-ubuntu1604

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# 安装git等
# opencv依赖：libglib2.0-0, libsm6
RUN apt-get update -y \
    && apt-get install -y build-essential git \
        libglib2.0-0 libsm6 libxrender1 \
    && rm -rf /var/lib/apt/lists/*

# 安装基础库
RUN pip --no-cache-dir install \
        numpy \
        pandas \
        easydict \
        Cython \
        opencv-python \
        opencv-contrib-python==3.4.2.16 \
        h5py \
        lmdb \
        lxml \
        bs4 \
        tensorflow==1.8 \
        tensorflow-gpu==1.8 \
        keras==2.1.5 \
        torch torchvision

RUN cd / \
    && git clone https://github.com/zergmk2/darknet.git \
    && cd darknet/ \
    && make 

# 安装server服务相关
RUN pip --no-cache-dir install flask flask_restful jsonschema \
    && pip install git+https://github.com/ibbd-dev/python-fire-rest.git

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm

# 解决时区问题
ENV TZ "Asia/Shanghai"
