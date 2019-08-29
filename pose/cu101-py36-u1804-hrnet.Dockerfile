# Pull base image.
# FROM mettainnovations/ubuntu-base:16.04-cuda10
FROM registry.cn-hangzhou.aliyuncs.com/ibbd/cuda:cuda101-cudnn7-py36-ubuntu1804

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# system dependencies
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        git \
    && rm -rf /var/lib/apt/lists/*

# install pytorch: https://pytorch.org/
RUN pip3 install torch torchvision

# install dependencies
ENV HRNET hrnet
RUN cd / \
    && git clone https://github.com/leoxiaobin/deep-high-resolution-net.pytorch "$HRNET" \
    && cd "$HRNET" \
    && pip3 install -r requirements.txt \
    && rm -rf .* \
    && rm -f *.md

# make libs
RUN cd "$HRNET"/lib \
    && make \
    && make clean

# Install COCOAPI
ENV COCOAPI /cocoapi \
RUN git clone https://github.com/cocodataset/cocoapi.git $COCOAPI \
    && cd $COCOAPI/PythonAPI \
    && make install \
    && python3 setup.py install --user \
    && rm -rf .* \
    && rm -f *.md

# Install server
RUN git clone https://github.com/ibbd-dev/python-fire-rest /fire-rest \
    && cd /fire-rest \
    && pip3 install -r requirements.txt \
    && python3 setup.py install --user \
    && rm -rf .* \
    && rm -f *.md

# dowonloads models
# MPII
# https://drive.google.com/open?id=1_wn2ifmoQprBrFvUCDedjPON4Y6jsN-v
# COCO val2017
# https://drive.google.com/open?id=1zYC7go9EV0XaSlSBjMaiyE_4TcHc_S38
# https://drive.google.com/open?id=1fGN2P81JEgzjLxCn5_PaOwaoUwT0Ybc3
# https://drive.google.com/open?id=15T2XqPjW7Ex0uyC1miGVYUv7ULOxIyJI
# https://drive.google.com/open?id=1UoJhTtjHNByZSm96W3yFTfU5upJnsKiS
# imagenet
# https://drive.google.com/open?id=1aTXmxKAJVLsXbvM-TmQ0ZjJxP868G73q
# https://drive.google.com/open?id=1qm5-QfHTz5Ia71ByZ1Haq5zJpyEbZRoc
