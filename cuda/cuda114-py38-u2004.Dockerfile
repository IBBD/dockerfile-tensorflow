#

# docker pull nvidia/cuda:11.4.0-devel-ubuntu20.04
FROM nvidia/cuda:11.4.0-devel-ubuntu20.04

MAINTAINER Alex Cai "cyy0523xc@gmail.com"
ENV DEBIAN_FRONTEND noninteractive

# 安装Python3.8, pip, git等
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        git \
        wget \
        curl \
        python3 \
        python3-dev \
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
