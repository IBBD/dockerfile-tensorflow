# Pull base image.
FROM python:3.6-slim

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# install base tools: git, wget, pip...
# install opencv
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        git \
        wget \
        libglib2.0-0 \
        libsm6 \
        libxrender1 \
        python3-dev \
    && wget https://bootstrap.pypa.io/get-pip.py \
    && python3 get-pip.py \
    && rm get-pip.py \
    && python3 -m pip install -U setuptools \
    && python3 -m pip --no-cache-dir install \
        numpy \
        pandas \
        scipy \
        scikit-learn \
        opencv-python \
        opencv-contrib-python==3.4.2.16 \
    && rm -rf /var/lib/apt/lists/*

# install ffmpeg
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends software-properties-common \
    && add-apt-repository ppa:jonathonf/ffmpeg-4 -y \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
        ffmpeg \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*

        
# 安装服务常用包
# moviepy依赖：imageio-ffmpeg
RUN python3 -m pip --no-cache-dir install \
        pytesseract \
        moviepy \
        imageio-ffmpeg \
        flask \
        flask_jsonrpc \
        fire \
        requests_toolbelt \
        jsonschema \
        flask_restful

# 安装额外的package
RUN python3 -m pip install git+https://github.com/ibbd-dev/python-fire-rest.git 
