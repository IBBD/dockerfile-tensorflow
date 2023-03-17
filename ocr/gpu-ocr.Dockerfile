#
# ocr Dockerfile
# 20230317: 单独用于ocr的dockerfile
#

# FROM registry.cn-hangzhou.aliyuncs.com/ibbd/cuda:cuda102-cudnn7-py38-ubuntu2004-dev
FROM nvidia/cuda:11.7.1-cudnn8-runtime-ubuntu22.04

LABEL user="Alex Cai"
LABEL email="cyy0523xc@gmail.com"
LABEL version="3.0"
LABEL description="v3-20220506"

ENV DEBIAN_FRONTEND noninteractive

# 安装Python3, pip, git等
RUN rm -rf /etc/apt/sources.list.d/ \
    && mkdir /etc/apt/sources.list.d/ \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
        git \
        wget \
        python3 \
        python3-dev \
        libglib2.0-0 libsm6 libxext-dev libxrender1 libgl1-mesa-glx \
    && wget https://bootstrap.pypa.io/get-pip.py \
    && python3 get-pip.py \
    && rm get-pip.py \
    && alias cpip='pip install -i https://mirrors.aliyun.com/pypi/simple/' \
    && rm -rf /var/lib/apt/lists/*

# install paddle
# RUN pip3 install paddlepaddle-gpu -i https://mirror.baidu.com/pypi/simple \
#     && pip3 install paddleocr -i https://mirror.baidu.com/pypi/simple

# 阿里云的源是比较快的
RUN pip3 config set global.index-url https://mirrors.aliyun.com/pypi/simple/
# RUN pip3 config set global.index-url http://mirrors.cloud.tencent.com/pypi/simple
# RUN pip3 config set global.index-url http://pypi.douban.com/simple/
# RUN pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

# 安装基础库
RUN copy ./requirements.txt /requirements.txt \
    && pip install -r /requirements.txt \
    && python3 -c "import cv2"

# 安装ibbd相关的基础模块
RUN pip3 install -r https://gitee.com/deeao/python-ibbd-algo/raw/master/requirements.txt \
    && pip3 install git+https://gitee.com/deeao/python-ibbd-algo.git \
    && pip3 install -r https://gitee.com/deeao/python-image-utils/raw/master/requirements.txt \
    && pip3 install git+https://gitee.com/deeao/python-image-utils.git

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：
# terminal is not fully functional
ENV LANG C.UTF-8
ENV TERM xterm
ENV PYTHONIOENCODING utf-8
# 解决时区问题
ENV TZ "Asia/Shanghai"
