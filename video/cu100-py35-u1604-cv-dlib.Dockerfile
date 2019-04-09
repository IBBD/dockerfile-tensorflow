# Pull base image.
FROM registry.cn-hangzhou.aliyuncs.com/ibbd/cuda:cuda100-cudnn7-py36-ubuntu1604

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# 安装基础库, opencv
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        libglib2.0-0 \
        libsm6 \
        libxrender1 \
    && pip install -U setuptools \
    && pip --no-cache-dir install \
        numpy \
        pandas \
        scipy \
        scikit-learn \
        opencv-python \
        opencv-contrib-python==3.4.2.16 
        
# 安装 DLIB
# python setup.py install --yes USE_AVX_INSTRUCTIONS --yes DLIB_USE_CUDA --set CMAKE_PREFIX_PATH=/usr/local/cuda --set CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda/bin/ --clean
# https://github.com/ageitgey/face_recognition/issues/455
# The --yes options to dlib's setup.py don't do anything since all these options
    #&& apt-get install -y git cmake libboost-all-dev libx11-dev \
# are on by default. So --yes has been removed. Do not give it to setup.py.
    # && python setup.py install \
        # --yes USE_AVX_INSTRUCTIONS \
        # --yes DLIB_USE_CUDA \
        # --set CMAKE_PREFIX_PATH=/usr/local/cuda \
        # --set CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda/bin/ \
        # --clean \
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends git cmake \
    && cd /root/ \
    && git clone https://github.com/davisking/dlib.git \
    && cd /root/dlib \
    && python3 setup.py install \
    && cd .. \
    && rm -r dlib
