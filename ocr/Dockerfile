#
# tensorflow Dockerfile
#

# Pull base image.
# FROM tensorflow/tensorflow:1.8.0-py3
FROM python:3.6-slim

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

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
        tensorflow==1.8 \
        keras==2.1.5

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm

# 解决时区问题
ENV TZ "Asia/Shanghai"
