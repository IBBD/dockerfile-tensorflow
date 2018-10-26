#
# tensorflow Dockerfile
#

# Pull base image.
#FROM tensorflow/tensorflow:latest-py3
FROM python:3.6-stretch

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# Pick up some TF dependencies
#RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime 

# 安装基础库
RUN pip install -U pip setuptools \
    && pip --no-cache-dir install \
        numpy \
        pandas \
        scipy \
        sklearn 

# install tensorflow: 自己在本地编译好的版本
ARG TF_PACKAGE=tensorflow
COPY build/tensorflow-1.11.0-cp36-cp36m-linux_x86_64.whl /tensorflow-1.11.0-cp36-cp36m-linux_x86_64.whl
RUN pip install /tensorflow-1.11.0-cp36-cp36m-linux_x86_64.whl \
    && rm -f /tensorflow-1.11.0-cp36-cp36m-linux_x86_64.whl

# 安装服务常用包
RUN pip --no-cache-dir install \
    keras \
    flask \
    flask_jsonrpc \
    fire

COPY bashrc /etc/bash.bashrc
RUN chmod a+rwx /etc/bash.bashrc

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm

# 解决时区问题
ENV TZ "Asia/Shanghai"
