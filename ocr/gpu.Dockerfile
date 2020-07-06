#
# gpu Dockerfile
#

# Pull base image.
FROM registry.cn-hangzhou.aliyuncs.com/ibbd/cuda:cuda102-cudnn7-py36-ubuntu1804

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# 安装git等
# install tesseract
# opencv依赖：libglib2.0-0, libsm6
# curl \
# build-essential 
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        libglib2.0-0 libsm6 libxrender1 \
        tesseract-ocr \
        tesseract-ocr-chi-sim \
        tesseract-ocr-chi-tra \
    && rm -rf /var/lib/apt/lists/*

# add ocr file
COPY ./chi_sim_best.traineddata /usr/share/tesseract-ocr/4.00/tessdata/chi_sim_best.traineddata

# 安装基础库
# opencv-contrib-python==3.4.2.16 \
# requests
# tensorflow==1.14 \
# tensorflow-gpu==1.14 \
# keras \
#        Cython \
RUN pip3 --no-cache-dir install \
        pandas \
        easydict \
        opencv-python \
        h5py \
        lmdb \
        lxml \
        bs4 \
        scikit-image \
        torch torchvision \
        pytesseract

# install darknet
# RUN cd / \
    # && git clone https://github.com/zergmk2/darknet.git \
    # && cd darknet/ \
    # && make 

# install paddle
# 约630M
RUN pip3 --no-cache-dir install paddlepaddle-gpu==1.7.2.post107 \
    && mkdir /paddle \
    && cd /paddle \
    && git clone https://github.com/PaddlePaddle/PaddleOCR \
    && cd PaddleOCR \
    && pip3 install -r requirments.txt 

# 安装ibbd相关的基础模块
# Pillow版本过高会导致：
# ImportError: cannot import name 'PILLOW_VERSION'
# && pip3 install Pillow==6.2.2 
RUN pip3 install -r https://github.com/ibbd-dev/python-ibbd-algo/raw/master/requirements.txt \
    && pip3 install git+https://github.com/ibbd-dev/python-ibbd-algo.git \
    && pip3 install -r https://github.com/ibbd-dev/python-image-utils/raw/master/requirements.txt \
    && pip3 install git+https://github.com/ibbd-dev/python-image-utils.git
