# https://www.learnopencv.com/install-opencv3-on-ubuntu/

FROM registry.cn-hangzhou.aliyuncs.com/ibbd/video:cuda10_cudnn7_py3
LABEL maintainer Aaron "wanglj@ibbd.net"

ENV OPENCV_VERSION 3.4.2
# Download OpenCV
RUN \
    wget https://github.com/opencv/opencv/archive/$OPENCV_VERSION.zip -O opencv3.zip && \
    unzip -q opencv3.zip && \
    mv /opencv-$OPENCV_VERSION /opencv && \
    rm opencv3.zip && \
    wget https://github.com/opencv/opencv_contrib/archive/$OPENCV_VERSION.zip -O opencv_contrib3.zip && \
    unzip -q opencv_contrib3.zip && \
    mv /opencv_contrib-$OPENCV_VERSION /opencv_contrib && \
    rm opencv_contrib3.zip 

