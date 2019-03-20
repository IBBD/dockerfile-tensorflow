#
# base image: tensorflow-notebook
# add pytorch, jieba, fasttext, nltk
#

# Pull base image.
FROM ubuntu:16.04

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# install base
# opencv依赖：
# ImportError: libgthread-2.0.so.0
# ImportError: libSM.so.6
# ImportError: libXrender.so.1
RUN apt-get update -y \
    && apt-get install -y \
        wget \
        python python-dev \
        gcc \
        git \
        libglib2.0-0 \
        libsm6 \
        libxrender1 \
    && wget https://bootstrap.pypa.io/get-pip.py \
    && python get-pip.py \
    && rm get-pip.py

# pip install
# mxnet
RUN pip install \
        scipy \
        easydict \
        scikit-learn \
        scikit-image \
        opencv-python \
        opencv-contrib-python \
        mxnet-cu90

# insightface
RUN mkdir /face \
    && cd face \
    && git clone --recursive https://github.com/deepinsight/insightface.git

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm

# 解决时区问题
ENV TZ "Asia/Shanghai"
