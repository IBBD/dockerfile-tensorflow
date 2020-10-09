#
# gpu Dockerfile
#

FROM registry.cn-hangzhou.aliyuncs.com/ibbd/cuda:cuda102-cudnn7-runtime-py36-ubuntu1804

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# 安装依赖软件
# opencv依赖：libglib2.0-0, libsm6, libxext-dev, libgl1-mesa-glx
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        libglib2.0-0 libsm6 libxext-dev libxrender1 libgl1-mesa-glx \
    && rm -rf /var/lib/apt/lists/*

# 安装基础库
RUN pip3 --no-cache-dir install \
        numpy \
        scikit-learn \
        scikit-image \
        opencv-python \
        mxnet-cu102 \
        fastapi \
        uvicorn \
        python-multipart \
    && python3 -c "import cv2"

# 安装ibbd相关的基础模块
RUN pip3 install -r https://github.com/ibbd-dev/python-ibbd-algo/raw/master/requirements.txt \
    && pip3 install git+https://github.com/ibbd-dev/python-ibbd-algo.git \
    && pip3 install -r https://github.com/ibbd-dev/python-image-utils/raw/master/requirements.txt \
    && pip3 install git+https://github.com/ibbd-dev/python-image-utils.git