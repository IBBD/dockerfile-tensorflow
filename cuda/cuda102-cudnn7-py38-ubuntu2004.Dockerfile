#
# cuda10.2 cudnn7 python3.8 ubuntu20.04 Dockerfile
# 安装基础包及工具

# Pull base image.
FROM registry.cn-hangzhou.aliyuncs.com/ibbd/cuda-base:cuda102-cudnn7-u2004

MAINTAINER Alex Cai "cyy0523xc@gmail.com"
ENV DEBIAN_FRONTEND noninteractive

# 安装Python3.8, pip, git等
RUN rm -rf /etc/apt/sources.list.d/ \
    && mkdir /etc/apt/sources.list.d/ \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
        git \
        wget \
        python3 \
        python3-dev \
    && wget https://bootstrap.pypa.io/get-pip.py \
    && python3 get-pip.py \
    && rm get-pip.py \
    && alias cpip='pip install -i https://mirrors.aliyun.com/pypi/simple/' \
    && rm -rf /var/lib/apt/lists/*

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：
# terminal is not fully functional
ENV LANG C.UTF-8
ENV TERM xterm
ENV PYTHONIOENCODING utf-8
# 解决时区问题
ENV TZ "Asia/Shanghai"
