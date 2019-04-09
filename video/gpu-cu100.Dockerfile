# Pull base image.
FROM registry.cn-hangzhou.aliyuncs.com/ibbd/video:cu100-py36-u1604-cv-dlib

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# install base
# tesseract-ocr-chi-sim-vert \
# tesseract-ocr-chi-tra-vert
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends software-properties-common \
    && add-apt-repository ppa:jonathonf/ffmpeg-4 -y \
    && add-apt-repository ppa:alex-p/tesseract-ocr -y \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
        ffmpeg \
        tesseract-ocr \
        tesseract-ocr-chi-sim \
        tesseract-ocr-chi-tra \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*
        
# 安装服务常用包
# moviepy依赖：imageio-ffmpeg
RUN python -m pip --no-cache-dir install \
        pytesseract \
        moviepy \
        imageio-ffmpeg \
        flask \
        flask_jsonrpc \
        fire \
        requests_toolbelt \
        pycrypto \
        jsonschema \
        flask_restful

# 安装额外的package
RUN python -m pip install git+https://github.com/cyy0523xc/face_lib.git \
    && python -m pip install git+https://github.com/ibbd-dev/python-fire-rest.git 
