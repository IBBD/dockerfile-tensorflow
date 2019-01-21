# https://www.learnopencv.com/install-opencv3-on-ubuntu/
# https://github.com/Valian/docker-python-opencv-ffmpeg/blob/master/Dockerfile-py3-cuda
# 阿里云 build

FROM registry.cn-hangzhou.aliyuncs.com/ibbd/video:dlib_base
LABEL maintainer Aaron "wanglj@ibbd.net"

# Install all dependencies for OpenCV
RUN apt-get -y update && \
    apt-get -y install \
        python3-dev \
        git \
        wget \
        unzip \
        cmake \
        build-essential \
        pkg-config \
        libatlas-base-dev \
        gfortran \
        libjasper-dev \
        libgtk2.0-dev \
        libavcodec-dev \
        libavformat-dev \
        libswscale-dev \
        libjpeg-dev \
        libpng-dev \
        libtiff-dev \
        libjasper-dev \
        libv4l-dev 

# Download OpenCV
ENV OPENCV_VERSION 3.4.5
RUN wget https://github.com/opencv/opencv/archive/$OPENCV_VERSION.zip -O opencv3.zip && \
    unzip -q opencv3.zip && \
    mv /opencv-$OPENCV_VERSION /opencv && \
    rm opencv3.zip && \
    wget https://github.com/opencv/opencv_contrib/archive/$OPENCV_VERSION.zip -O opencv_contrib3.zip && \
    unzip -q opencv_contrib3.zip && \
    mv /opencv_contrib-$OPENCV_VERSION /opencv_contrib && \
    rm opencv_contrib3.zip && \
    rm -rf /var/lib/apt/lists/* 