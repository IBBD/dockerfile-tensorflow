FROM debian:stretch-slim

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

RUN apt-get update -y \
    && apt-get install -y wget

RUN mkdir /models/ \
    && cd /models \
    && wget https://pjreddie.com/media/files/yolov3.weights 

RUN cd /models \
    && wget https://pjreddie.com/media/files/yolov3-tiny.weights

RUN cd /models \
    && wget https://pjreddie.com/media/files/yolov3-spp.weights

ADD gdown.pl /gdown.pl
RUN chmod +x /gdown.pl 

RUN ./gdown.pl "https://drive.google.com/open?id=1FlHeQjWEQVJt0ay1PVsiuuMzmtNyv36m" \
    /models/enetb0-coco_final.weights 
