# Pull base image.
FROM registry.cn-hangzhou.aliyuncs.com/ibbd/cuda:cuda101-cudnn7-py36-ubuntu1804

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# 安装基础库, opencv
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        libglib2.0-0 \
        libsm6 \
        libxrender1 \
        libxext-dev \
        pkg-config \
    && pip install -U setuptools \
    && pip --no-cache-dir install \
        pandas \
        opencv-python \
        opencv-contrib-python \
        imageio-ffmpeg \
        tensorflow-gpu==1.15 \
        keras \
        pillow \
        cython \
        tqdm

# 安装自有工具
RUN pip install -r https://github.com/ibbd-dev/python-ibbd-algo/raw/master/requirements.txt \
    && pip install git+https://github.com/ibbd-dev/python-ibbd-algo.git \
    && pip install -r https://github.com/ibbd-dev/python-image-utils/raw/master/requirements.txt \
    && pip install git+https://github.com/ibbd-dev/python-image-utils.git
