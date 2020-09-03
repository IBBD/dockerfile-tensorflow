# Pull base image.
# 在1050TI上使用10.0以上版本有问题
# FROM registry.cn-hangzhou.aliyuncs.com/ibbd/cuda:cuda102-cudnn7-py36-ubuntu1804
# FROM registry.cn-hangzhou.aliyuncs.com/ibbd/cuda:cuda102-cudnn7-py36-ubuntu1804
FROM registry.cn-hangzhou.aliyuncs.com/ibbd/cuda:cuda102-cudnn7-runtime-py36-ubuntu1804

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# 安装基础库, opencv
# keras与tensorflow的版本对应关系：
# https://blog.csdn.net/weixin_40109345/article/details/106730050
# opencv新增依赖：libgl1-mesa-glx
#    && pip install -U setuptools \
#        opencv-contrib-python \
#        imageio-ffmpeg \
#        pandas \
#        cython \
#        tqdm \
#        pkg-config \
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        libglib2.0-0 \
        libsm6 \
        libxrender1 \
        libxext-dev \
        libgl1-mesa-glx \
    && pip --no-cache-dir install \
        numpy \
        matplotlib \
        opencv-python \
        tensorflow-gpu==1.15 \
        keras==2.3.1 \
        pillow \
        fastapi \
        uvicorn \
        python-multipart \
    && python3 -c "import cv2"

# 安装自有工具
RUN pip install -r https://github.com/ibbd-dev/python-ibbd-algo/raw/master/requirements.txt \
    && pip install git+https://github.com/ibbd-dev/python-ibbd-algo.git \
    && pip install -r https://github.com/ibbd-dev/python-image-utils/raw/master/requirements.txt \
    && pip install git+https://github.com/ibbd-dev/python-image-utils.git
