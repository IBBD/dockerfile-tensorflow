#
FROM ubuntu:20.04

LABEL maintainer "Alex Cai <cyy0523xc@qq.com>"

# ---------------------------------------------------------------
# ----------------------- install cuda --------------------------
# ---------------------------------------------------------------

# 在2004的源里没有10.2这个版本，安装不了
RUN apt-get update && apt-get install -y --no-install-recommends \
    gnupg2 curl ca-certificates && \
    curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub | apt-key add - && \
    echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/cuda.list && \
    echo "deb https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list && \
    apt-get purge --autoremove -y curl \
    && rm -rf /var/lib/apt/lists/*

ENV CUDA_VERSION 10.2.89
ENV CUDA_PKG_VERSION 10-2=$CUDA_VERSION-1

# For libraries in the cuda-compat-* package: https://docs.nvidia.com/cuda/eula/index.html#attachment-a
RUN apt-get update && apt-get install -y --no-install-recommends \
    cuda-cudart-$CUDA_PKG_VERSION \
    cuda-compat-10-2 \
    && ln -s cuda-10.2 /usr/local/cuda && \
    rm -rf /var/lib/apt/lists/*

# Required for nvidia-docker v1
RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
    echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf

ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
ENV NVIDIA_REQUIRE_CUDA "cuda>=10.2 brand=tesla,driver>=396,driver<397 brand=tesla,driver>=410,driver<411 brand=tesla,driver>=418,driver<419 brand=tesla,driver>=440,driver<441"

# copy from: https://gitlab.com/nvidia/container-images/cuda/-/blob/master/dist/10.2/ubuntu18.04-x86_64/runtime/Dockerfile
ENV NCCL_VERSION 2.7.8

RUN apt-get update && apt-get install -y --no-install-recommends \
    cuda-libraries-$CUDA_PKG_VERSION \
    cuda-npp-$CUDA_PKG_VERSION \
    cuda-nvtx-$CUDA_PKG_VERSION \
    libcublas10=10.2.2.89-1 \
    libnccl2=$NCCL_VERSION-1+cuda10.2 \
    && apt-mark hold libnccl2 \
    && rm -rf /var/lib/apt/lists/*

# copy from: https://gitlab.com/nvidia/container-images/cuda/-/blob/master/dist/10.2/ubuntu18.04-x86_64/devel/Dockerfile
ENV NCCL_VERSION 2.7.8

RUN apt-get update && apt-get install -y --no-install-recommends \
    cuda-nvml-dev-$CUDA_PKG_VERSION \
    cuda-command-line-tools-$CUDA_PKG_VERSION \
    cuda-nvprof-$CUDA_PKG_VERSION \
    cuda-npp-dev-$CUDA_PKG_VERSION \
    cuda-libraries-dev-$CUDA_PKG_VERSION \
    cuda-minimal-build-$CUDA_PKG_VERSION \
    libcublas-dev=10.2.2.89-1 \
    libnccl-dev=2.7.8-1+cuda10.2 \
    && apt-mark hold libnccl-dev \
    && rm -rf /var/lib/apt/lists/*

ENV LIBRARY_PATH /usr/local/cuda/lib64/stubs

# copy from: https://gitlab.com/nvidia/container-images/cuda/-/blob/master/dist/10.2/ubuntu18.04-x86_64/devel/cudnn7/Dockerfile
ENV CUDNN_VERSION 7.6.5.32

LABEL com.nvidia.cudnn.version="${CUDNN_VERSION}"

RUN apt-get update && apt-get install -y --no-install-recommends \
    libcudnn7=$CUDNN_VERSION-1+cuda10.2 \
    libcudnn7-dev=$CUDNN_VERSION-1+cuda10.2 \
    && apt-mark hold libcudnn7 && \
    rm -rf /var/lib/apt/lists/*

# -----------------------------------------------------------------
# ----------------------- install python --------------------------
# -----------------------------------------------------------------

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
    && rm -rf /var/lib/apt/lists/*\
    && alias cpip='pip install -i https://mirrors.aliyun.com/pypi/simple/' \
    && pip3 config set global.index-url https://mirrors.aliyun.com/pypi/simple/

# ------------------------------------------------------------------
# ----------------------- install 各类应用 --------------------------
# ------------------------------------------------------------------

# install paddle
RUN pip3 install paddlepaddle-gpu -i https://mirror.baidu.com/pypi/simple \
    && pip3 install paddleocr -i https://mirror.baidu.com/pypi/simple

# 安装依赖软件
# opencv依赖：libglib2.0-0, libsm6, libxext-dev
#        curl \
#        build-essential \
# opencv4.4 报错：
# ImportError: libGL.so.1: cannot open shared object file: No such file or directory
# 需要安装：libgl1-mesa-glx
# ethtool, net-tools: 获取硬件信息时依赖
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        libglib2.0-0 libsm6 libxext-dev libxrender1 libgl1-mesa-glx \
    && rm -rf /var/lib/apt/lists/*

# 安装基础库
# EasyDict可以让你像访问属性一样访问dict里的变量
# LMDB文件可以同时由多个进程打开，具有极高的数据存取速度，访问简单，不需要运行单独的数据库管理进程，只要在访问数据的代码里引用LMDB库，访问时给文件路径即可。
# h5py: 操作HDF5
# HDF5 拥有一系列的优异特性，使其特别适合进行大量科学数据的存储和操作，如它支持非常多的数据类型，灵活，通用，跨平台，可扩展，高效的 I/O 性能，支持几乎无限量（高达 EB）的单文件存储等
# lxml是处理XML和HTML的python语言
# 20211027 flashtext: 高效的文本处理工具
# pytesseract \
RUN pip3 --no-cache-dir install \
        numpy \
        pandas \
        scipy \
        easydict \
        pillow \
        scikit-learn \
        scikit-image \
        opencv-python \
        fastapi uvicorn python-multipart \
        gunicorn uvloop httptools \
        pyclipper \
        shapely \
        fuzzywuzzy python-Levenshtein \
        flashtext \
    && python3 -c "import cv2"

# 安装ibbd相关的基础模块
RUN pip3 install -r https://github.com/ibbd-dev/python-ibbd-algo/raw/master/requirements.txt \
    && pip3 install git+https://github.com/ibbd-dev/python-ibbd-algo.git \
    && pip3 install -r https://github.com/ibbd-dev/python-image-utils/raw/master/requirements.txt \
    && pip3 install git+https://github.com/ibbd-dev/python-image-utils.git
