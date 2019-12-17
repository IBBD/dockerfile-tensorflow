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
        git \
    && pip install -U setuptools \
    && pip --no-cache-dir install \
        numpy \
        pandas \
        scipy \
        scikit-learn \
        matplotlib \
        opencv-python \
        opencv-contrib-python \
        tensorflow-gpu \
        keras \
        pillow \
        cython \
        tqdm

# 安装服务常用包
RUN python3 -m pip --no-cache-dir install \
        imageio-ffmpeg \
        fire \
    && python3 -m pip install -r https://github.com/ibbd-dev/python-fire-rest/raw/master/requirements.txt
    && python3 -m pip install git+https://github.com/ibbd-dev/python-fire-rest.git 
