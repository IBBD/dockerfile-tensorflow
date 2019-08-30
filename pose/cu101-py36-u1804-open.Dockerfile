# Pull base image.
# FROM mettainnovations/ubuntu-base:16.04-cuda10
FROM registry.cn-hangzhou.aliyuncs.com/ibbd/cuda:cuda101-cudnn7-py36-ubuntu1804

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# system dependencies
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        cmake \
        git \
        libopencv-dev \
        libatlas-base-dev \
        libprotobuf-dev \
        libleveldb-dev \
        libsnappy-dev \
        libhdf5-serial-dev \
        protobuf-compiler \
        libgflags-dev \
        libgoogle-glog-dev \
        liblmdb-dev \
    && apt-get install -y --no-install-recommends libboost-all-dev \
    && pip3 install --upgrade pip \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade numpy protobuf

# Install openpose
RUN git clone https://github.com/CMU-Perceptual-Computing-Lab/openpose /openpose \
    && cd /openpose \
    && rm -rf .git \
    && rm -f *.md \
    && mkdir build \
    && cd build \
    && cmake .. \
    && cd /openpose/build \
    && make -j`nproc`

# Install server
RUN git clone https://github.com/ibbd-dev/python-fire-rest /fire-rest \
    && cd /fire-rest \
    && pip3 install -r requirements.txt \
    && python3 setup.py install --user \
    && rm -rf .git \
    && rm -f *.md

WORKDIR /openpose
