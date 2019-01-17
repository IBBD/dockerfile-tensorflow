#
# tensorflow GPU Dockerfile
#

# Pull base image.
FROM mettainnovations/dlib:19.16-cuda10.0

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# install base
        #tesseract-ocr-chi-sim-vert \
        #tesseract-ocr-chi-tra-vert
RUN add-apt-repository ppa:jonathonf/ffmpeg-4 \
    && apt-get update \
    && apt-get install -y python3-pip \
        ffmpeg \
        tesseract-ocr \
        tesseract-ocr-chi-sim \
        tesseract-ocr-chi-tra 
    
# 安装基础库
RUN pip3 install -U pip setuptools \
    && pip3 --no-cache-dir install \
        numpy \
        pandas \
        scipy \
        sklearn \
        opencv-python \
        pytesseract \
        moviepy

# 安装服务常用包
RUN pip3 --no-cache-dir install \
    flask \
    flask_jsonrpc \
    fire \
    requests_toolbelt \
    pycrypto \
    jsonschema

# 安装额外的package
RUN pip3 install git+https://github.com/cyy0523xc/face_lib.git \
    && pip3 install git+https://github.com/ibbd-dev/python-fire-rest.git

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm

# 解决时区问题
ENV TZ "Asia/Shanghai"
