# Pull base image.
FROM registry.cn-hangzhou.aliyuncs.com/ibbd/cuda:cuda100-cudnn7-py35-ubuntu1604

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

# 安装pytorch
# https://pytorch.org/get-started/locally/
RUN pip3 install https://download.pytorch.org/whl/cu100/torch-1.0.1.post2-cp35-cp35m-linux_x86_64.whl \
    && pip3 install torchvision

# 安装服务常用包
RUN python3 -m pip --no-cache-dir install \
        imageio-ffmpeg \
        flask \
        flask_jsonrpc \
        fire \
        jsonschema \
        flask_restful \
        flask_cors \
    && python3 -m pip install git+https://github.com/ibbd-dev/python-fire-rest.git 
