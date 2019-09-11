FROM registry.cn-hangzhou.aliyuncs.com/ibbd/paddle:latest

# install
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        ffmpeg \
        libglib2.0-0 \
        libsm6 \
        libxrender1 \
    && pip3 install \
        numpy \
        pandas \
        Cython \
        opencv-contrib-python \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# install cocoapi
# 安装至全局site-packages
RUN ln -s /usr/bin/python3 /usr/bin/python 
RUN git clone https://github.com/cocodataset/cocoapi.git /cocoapi \
    && cd /cocoapi/PythonAPI \
    && make install 

# install requirements
RUN cd /models/PaddleCV/PaddleDetection \
    && pip3 install -r requirements.txt
