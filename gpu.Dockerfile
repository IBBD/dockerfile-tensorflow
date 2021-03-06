#
# tensorflow GPU Dockerfile
#

# Pull base image.
FROM tensorflow/tensorflow:latest-gpu-py3

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

# install keras
RUN pip install keras

# 安装服务常用包
RUN pip --no-cache-dir install \
    flask \
    flask_jsonrpc \
    fire

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm

# 解决时区问题
ENV TZ "Asia/Shanghai"
