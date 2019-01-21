# create registry.cn-hangzhou.aliyuncs.com/ibbd/video:py3_cuda_base

# Pull base image.
FROM mettainnovations/ubuntu-base:16.04-cuda10

LABEL maintainer Aaron "wanglj@ibbd.net"

# install base
#tesseract-ocr-chi-sim-vert \
#tesseract-ocr-chi-tra-vert
RUN add-apt-repository ppa:jonathonf/ffmpeg-4 \
    && apt-get update \
    && apt-get install -y python3 \
        python3-pip \
        ffmpeg \
        tesseract-ocr \
        tesseract-ocr-chi-sim \
        tesseract-ocr-chi-tra 
        
# pip 升级
RUN python3 -m pip install --upgrade pip

# 安装基础库
RUN python3 -m pip install -U setuptools \
    && python3 -m pip --no-cache-dir install \
        numpy \
        pandas \
        scipy \
        scikit-learn \
        pytesseract \
        moviepy
  
# 安装服务常用包
RUN python3 -m pip --no-cache-dir install \
    flask \
    flask-restful \
    flask_jsonrpc \
    fire \
    requests_toolbelt \
    pycrypto \
    jsonschema

# 安装额外的package
RUN python3 -m pip install git+https://github.com/cyy0523xc/face_lib.git \
    && python3 -m pip install git+https://github.com/ibbd-dev/python-fire-rest.git


# Install all dependencies for OpenCV
RUN apt-get -y update && \
    apt-get -y install \
        python3-dev \
        git \
        wget \
        unzip \
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
ENV OPENCV_VERSION 3.4.2
RUN wget https://github.com/opencv/opencv/archive/$OPENCV_VERSION.zip -O opencv3.zip && \
    unzip -q opencv3.zip && \
    mv /opencv-$OPENCV_VERSION /opencv && \
    rm opencv3.zip && \
    wget https://github.com/opencv/opencv_contrib/archive/$OPENCV_VERSION.zip -O opencv_contrib3.zip && \
    unzip -q opencv_contrib3.zip && \
    mv /opencv_contrib-$OPENCV_VERSION /opencv_contrib && \
    rm opencv_contrib3.zip
    
# 删除 apt lists
RUN rm -rf /var/lib/apt/lists/*

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm

# 解决时区问题
ENV TZ "Asia/Shanghai"