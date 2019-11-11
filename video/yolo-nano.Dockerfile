# https://github.com/liux0614/yolo_nano
FROM registry.cn-hangzhou.aliyuncs.com/ibbd/cuda:cuda101-cudnn7-py36-ubuntu1804

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# 安装基础库, opencv
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        libglib2.0-0 \
        libsm6 \
        libxrender1 \
    && python3 -m pip install -U setuptools \
    && python3 -m pip --no-cache-dir install \
        tqdm==4.32.2 \
        matplotlib==3.1.0 \
        numpy==1.16.3 \
        visdom==0.1.8.8 \
        Pillow==6.2.1 \
        opencv-python \
        opencv-contrib-python==3.4.2.16 
        
# 安装cocoapi及其依赖
RUN ln -s /usr/bin/python3 /usr/bin/python 
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        git \
    && python3 -m pip --no-cache-dir install \
        Cython \
    && pip3 install "git+https://github.com/philferriere/cocoapi.git#egg=pycocotools&subdirectory=PythonAPI" \
    && rm -rf /var/lib/apt/lists/*

# install pytorch
RUN pip3 install torch torchvision
