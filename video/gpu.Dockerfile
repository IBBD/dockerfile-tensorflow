# Pull base image.
FROM mettainnovations/ubuntu-base:16.04-cuda10

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# install base
#tesseract-ocr-chi-sim-vert \
#tesseract-ocr-chi-tra-vert
RUN add-apt-repository ppa:jonathonf/ffmpeg-4 && \
    add-apt-repository ppa:alex-p/tesseract-ocr && \
    apt-get update &&\
    apt-get install -y python3 \
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
        opencv-python \
        pytesseract \
        moviepy
        
# 安装 DLIB
RUN cd /root/ && \
    git clone https://github.com/davisking/dlib.git && \
    cd /root/dlib && \
    python3 setup.py install && \
    cd .. && \
    rm -r dlib
    
# 安装服务常用包
RUN python3 -m pip --no-cache-dir install \
    flask \
    flask_jsonrpc \
    fire \
    requests_toolbelt \
    pycrypto \
    jsonschema

# 安装额外的package
RUN python3 -m pip install git+https://github.com/cyy0523xc/face_lib.git \
    && python3 -m pip install git+https://github.com/ibbd-dev/python-fire-rest.git

# 删除 apt lists
RUN rm -rf /var/lib/apt/lists/*

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm

# 解决时区问题
ENV TZ "Asia/Shanghai"
