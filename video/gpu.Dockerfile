# Pull base image.
# FROM mettainnovations/ubuntu-base:16.04-cuda10
FROM registry.cn-hangzhou.aliyuncs.com/ibbd/video:cu101-py36-u1804-cv-dlib

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# install base
#tesseract-ocr-chi-sim-vert \
#tesseract-ocr-chi-tra-vert
RUN apt-get update -y \
    && apt-get install -y software-properties-common \
    && add-apt-repository ppa:jonathonf/ffmpeg-4 -y \
    && add-apt-repository ppa:alex-p/tesseract-ocr \
    && apt-get update \
    && apt-get install -y \
        ffmpeg \
        tesseract-ocr \
        tesseract-ocr-chi-sim \
        tesseract-ocr-chi-tra 
        
# 安装基础库
RUN python3 -m pip --no-cache-dir install \
        pytesseract \
        moviepy
        
# 安装服务常用包
RUN python3 -m pip --no-cache-dir install \
    flask \
    flask_jsonrpc \
    fire \
    requests_toolbelt \
    pycrypto \
    jsonschema \
    flask_restful

# 安装额外的package
# install ffmpeg from imageio.
RUN python3 -m pip install git+https://github.com/cyy0523xc/face_lib.git \
    && python3 -m pip install git+https://github.com/ibbd-dev/python-fire-rest.git \
    && python3 -c "import imageio; imageio.plugins.ffmpeg.download()"

# 删除 apt lists
RUN rm -rf /var/lib/apt/lists/*

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm

# 解决时区问题
ENV TZ "Asia/Shanghai"
