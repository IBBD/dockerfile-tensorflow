FROM debian:stretch-slim

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

RUN apt-get update -y \
    && apt-get install -y wget

RUN mkdir /models/ \
    && cd /models \
    && wget https://www.dropbox.com/s/0uxn14y26jcui4v/pspnet50_ade20k.h5?dl=1 \
        -O pspnet50_ade20k.h5

RUN cd /models \
    && wget https://www.dropbox.com/s/c17g94n946tpalb/pspnet101_cityscapes.h5?dl=1 \
        -O pspnet101_cityscapes.h5

RUN cd /models \
    && wget https://www.dropbox.com/s/uvqj2cjo4b9c5wg/pspnet101_voc2012.h5?dl=1 \
        -O pspnet101_voc2012.h5

