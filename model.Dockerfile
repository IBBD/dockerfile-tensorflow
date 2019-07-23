FROM debian:stretch-slim

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

RUN apt-get update -y \
    && apt-get install -y wget 

RUN mkdir -p /models/ \
    && cd /models 
RUN wget http://www.openslr.org/resources/18/data_thchs30.tgz 
#RUN wget http://www.openslr.org/resources/18/test-noise.tgz
#RUN wget http://www.openslr.org/resources/18/resource.tgz
#RUN wget http://www.openslr.org/resources/33/data_aishell.tgz
#RUN wget https://pjreddie.com/media/files/yolov3.weights
