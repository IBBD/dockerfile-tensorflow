#
# tensorflow base image Dockerfile
# see: https://github.com/tensorflow/tensorflow/blob/master/tensorflow/tools/dockerfiles/dockerfiles/cpu.Dockerfile

ARG UBUNTU_VERSION=16.04
FROM ubuntu:${UBUNTU_VERSION}

ARG USE_PYTHON_3_NOT_2=True
ARG _PY_SUFFIX=${USE_PYTHON_3_NOT_2:+3}
ARG PYTHON=python${_PY_SUFFIX}
ARG PIP=pip${_PY_SUFFIX}

# See http://bugs.python.org/issue19846
ENV LANG C.UTF-8

RUN apt-get update && apt-get install -y \
    ${PYTHON} \
    ${PYTHON}-pip

# 安装基础库
RUN ${PIP} install --upgrade \
    pip \
    setuptools \
    numpy \
    pandas \
    scipy \
    sklearn 

ARG TF_PACKAGE=tensorflow
RUN ${PIP} install ${TF_PACKAGE} keras

COPY bashrc /etc/bash.bashrc
RUN chmod a+rwx /etc/bash.bashrc

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm

# 解决时区问题
ENV TZ "Asia/Shanghai"
