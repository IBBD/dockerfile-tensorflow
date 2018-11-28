#
# tensorflow Dockerfile
#

# Pull base image.
FROM tensorflow/tensorflow:latest-py3

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# 安装基础库
RUN pip install -U pip setuptools \
    && pip --no-cache-dir install \
        numpy \
        pandas

# install tensorflow, keras
RUN pip --no-cache-dir install \
    keras

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm

# 解决时区问题
ENV TZ "Asia/Shanghai"
