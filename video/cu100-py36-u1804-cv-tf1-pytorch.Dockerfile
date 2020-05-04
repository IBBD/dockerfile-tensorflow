# Pull base image.
FROM registry.cn-hangzhou.aliyuncs.com/ibbd/cuda:cuda100-cudnn7-py36-ubuntu1804

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
        tensorflow==1.15 \
        keras \
        pillow \
        cython \
        tqdm

# 安装pytorch
# https://pytorch.org/get-started/locally/
# https://pytorch.org/get-started/locally/
# RUN pip3 install https://download.pytorch.org/whl/cu100/torch-1.1.0-cp36-cp36m-linux_x86_64.whl \
    # && pip3 install https://download.pytorch.org/whl/cu100/torchvision-0.3.0-cp36-cp36m-linux_x86_64.whl
RUN pip install torch torchvision

# 安装服务常用包  
RUN python3 -m pip --no-cache-dir install \
        imageio-ffmpeg \
        fastapi \
        uvicorn

# 安装自有工具
RUN pip install -r https://github.com/ibbd-dev/python-ibbd-algo/raw/master/requirements.txt \
    && pip install git+https://github.com/ibbd-dev/python-ibbd-algo.git \
    && pip install -r https://github.com/ibbd-dev/python-image-utils/raw/master/requirements.txt \
    && pip install git+https://github.com/ibbd-dev/python-image-utils.git
