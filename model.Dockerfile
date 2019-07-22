FROM debian:stretch-slim

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

RUN apt-get update -y \
    && apt-get install -y wget \
    && mkdir -p /models/ \
    && cd /models \
    && wget http://www.openslr.org/resources/33/data_aishell.tgz
    #&& wget https://pjreddie.com/media/files/yolov3.weights
