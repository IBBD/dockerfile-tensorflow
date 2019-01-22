# create registry.cn-hangzhou.aliyuncs.com/ibbd/video:py3_cuda_opencv_dlib

FROM registry.cn-hangzhou.aliyuncs.com/ibbd/video:py3_cuda_opencv
LABEL maintainer Aaron "wanglj@ibbd.net"

# 安装 DLIB
RUN cd /root/ && \
    git clone https://github.com/davisking/dlib.git && \
    cd /root/dlib && \
    python3 setup.py install && \
    cd .. && \
    rm -r /root/dlib