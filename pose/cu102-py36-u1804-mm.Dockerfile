# Pull base image.
FROM registry.cn-hangzhou.aliyuncs.com/ibbd/cuda:cuda102-cudnn7-py36-ubuntu1804

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# system dependencies
# opencv依赖：libglib2.0-0, libxrender1, libsm6, libxext-dev
# install pytorch: https://pytorch.org/
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        libglib2.0-0 \
        libsm6 \
        libxrender1 \
        libxext-dev \
        wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && pip3 --no-cache-dir install \
        numpy \
        pillow \
        opencv-python \
        fastapi uvicorn python-multipart \
        json_tricks \
        torch torchvision

# install mm
RUN pip3 --no-cache-dir install mmcv-full cython \
    && pip3 --no-cache-dir install "git+https://github.com/open-mmlab/mmdetection.git" \
    && pip3 --no-cache-dir install "git+https://github.com/cocodataset/cocoapi.git#subdirectory=PythonAPI" \
    && pip3 --no-cache-dir install "git+https://github.com/open-mmlab/mmpose.git"

# 安装ibbd相关的基础模块
RUN pip3 --no-cache-dir install -r https://github.com/ibbd-dev/python-ibbd-algo/raw/master/requirements.txt \
    && pip3 --no-cache-dir install git+https://github.com/ibbd-dev/python-ibbd-algo.git \
    && pip3 --no-cache-dir install -r https://github.com/ibbd-dev/python-image-utils/raw/master/requirements.txt \
    && --no-cache-dir pip3 install git+https://github.com/ibbd-dev/python-image-utils.git

# download models
# pose_resnet_50: 0.718@AP 280ms
# hrnet_w32: 0.746@AP 540ms
# hrnet_w48: 0.756@AP 660ms
# dark_pose_resnet_50: 0.724@AP
RUN mkdir /models \
    && cd /models \
    && wget https://openmmlab.oss-cn-hangzhou.aliyuncs.com/mmpose/top_down/resnet/res50_coco_256x192-ec54d7f3_20200709.pth \
    && wget https://openmmlab.oss-cn-hangzhou.aliyuncs.com/mmpose/top_down/hrnet/hrnet_w32_coco_256x192-c78dce93_20200708.pth \
    && wget https://openmmlab.oss-cn-hangzhou.aliyuncs.com/mmpose/top_down/hrnet/hrnet_w48_coco_256x192-b9e0b3ab_20200708.pth \
    && wget https://openmmlab.oss-cn-hangzhou.aliyuncs.com/mmpose/top_down/resnet/res50_coco_256x192_dark-43379d20_20200709.pth
