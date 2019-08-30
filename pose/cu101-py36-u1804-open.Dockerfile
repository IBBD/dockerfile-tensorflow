# Pull base image.
# 参考：https://github.com/ExSidius/openpose-docker/blob/master/Dockerfile
FROM registry.cn-hangzhou.aliyuncs.com/ibbd/cuda:cuda101-cudnn7-py36-ubuntu1804

MAINTAINER Alex Cai "cyy0523xc@gmail.com"
ENV DEBIAN_FRONTEND noninteractive

RUN echo "Installing dependencies..." \
	&& apt-get -y --no-install-recommends update \
	&& apt-get -y --no-install-recommends upgrade \
	&& apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        git \
        libatlas-base-dev \
        libprotobuf-dev \
        libleveldb-dev \
        libsnappy-dev \
        libhdf5-serial-dev \
        protobuf-compiler \
        libboost-all-dev \
        libgflags-dev \
        libgoogle-glog-dev \
        liblmdb-dev \
        pciutils \
        opencl-headers \
        ocl-icd-opencl-dev \
        libviennacl-dev \
        libcanberra-gtk-module \
        libopencv-dev \
    && rm -rf /var/lib/apt/lists/* \
    && pip3 install --upgrade pip \
	&& pip3 install \
        setuptools \
	    numpy \
	    protobuf \
	    opencv-python 

RUN echo "Downloading and building OpenPose..." \
	&& git clone https://github.com/CMU-Perceptual-Computing-Lab/openpose.git \
	&& mkdir -p /openpose/build \
	&& cd /openpose/build \
	&& cmake .. \
	&& make -j`nproc`

# Install server
RUN git clone https://github.com/ibbd-dev/python-fire-rest /fire-rest \
    && cd /fire-rest \
    && pip3 install -r requirements.txt \
    && python3 setup.py install --user \
    && rm -rf .git \
    && rm -f *.md

WORKDIR /openpose
