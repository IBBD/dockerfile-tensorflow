From registry.cn-hangzhou.aliyuncs.com/ibbd/face:mxnet-cu90-opencv-py3

# 安装 DLIB
RUN apt-get update -y \
    && apt-get install -y git cmake python3-dev \
    && cd /root/ \
    && git clone https://github.com/davisking/dlib.git \
    && cd /root/dlib \
    && python3 setup.py install \
    && cd .. \
    && rm -r dlib
