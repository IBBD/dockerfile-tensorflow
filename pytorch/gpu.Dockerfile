#
# gpu Dockerfile
#

FROM registry.cn-hangzhou.aliyuncs.com/ibbd/cuda:cuda102-cudnn7-py38-ubuntu2004

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# 安装python包
RUN pip3 --no-cache-dir install \
        numpy \
        pillow \
        fastapi \
        uvicorn \
        python-multipart \
        torch torchvision


# 安装ibbd相关的基础模块
RUN pip3 install -r https://github.com/ibbd-dev/python-ibbd-algo/raw/master/requirements.txt \
    && pip3 install git+https://github.com/ibbd-dev/python-ibbd-algo.git \
    && pip3 install -r https://github.com/ibbd-dev/python-image-utils/raw/master/requirements.txt \
    && pip3 install git+https://github.com/ibbd-dev/python-image-utils.git
