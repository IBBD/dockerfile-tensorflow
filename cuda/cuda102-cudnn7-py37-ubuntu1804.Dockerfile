#
# cuda10.2 cudnn7 python3.7 ubuntu18.04 Dockerfile
# 安装基础包及工具

# Pull base image.
FROM nvidia/cuda:10.2-cudnn7-devel-ubuntu18.04

MAINTAINER Alex Cai "cyy0523xc@gmail.com"
ENV DEBIAN_FRONTEND noninteractive

# 安装Python3.7, pip, git等
# 安装pip时报错：ModuleNotFoundError: No module named 'distutils.util'
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        git \
        wget \
        python3.7 \
        python3.7-dev \
    && ln -s /usr/bin/python3.7 /usr/bin/python \
    && ln -s /usr/bin/python3.7 /usr/bin/python3 \
    && wget https://bootstrap.pypa.io/get-pip.py \
    && python3 get-pip.py \
    && rm get-pip.py \
    && alias cpip='pip install -i https://pypi.tuna.tsinghua.edu.cn/simple' \
    && rm -rf /var/lib/apt/lists/*

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：
# terminal is not fully functional
ENV LANG C.UTF-8
ENV TERM xterm
ENV PYTHONIOENCODING utf-8
# 解决时区问题
ENV TZ "Asia/Shanghai"
