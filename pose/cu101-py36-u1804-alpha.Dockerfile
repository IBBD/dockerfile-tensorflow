# !! 该镜像编译不成功，依赖与Python2
# Pull base image.
FROM registry.cn-hangzhou.aliyuncs.com/ibbd/cuda:cuda101-cudnn7-py36-ubuntu1804

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# system dependencies
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        git \
        ffmpeg \
    && pip3 install --upgrade pip \
    && rm -rf /var/lib/apt/lists/* \
    && cp /usr/bin/python3 /usr/bin/python

# Install pytorch and tensorflow
# https://pytorch.org/
# https://www.tensorflow.org/install/gpu
RUN pip3 install torch torchvision \
    && pip3 install tensorflow-gpu

# Get the code and build related modules.
# make: python2: Command not found
RUN cd / \
    && git clone https://github.com/MVIG-SJTU/AlphaPose.git /AlphaPose \
    && cd /AlphaPose/ \
    && rm -rf .git \
    && rm -f *.md \
    && cd human-detection/lib/ \
    && make clean \
    && make \
    && cd newnms/ \
    && make 

# Install related dependencies 
RUN cd /AlphaPose/ \
    && chmod +x install.sh \
    && sh install.sh

# Download pre-trained models
RUN cd /AlphaPose/ \
    && chmod +x fetch_models.sh \
    && sh fetch_models.sh

# Install server
RUN git clone https://github.com/ibbd-dev/python-fire-rest /fire-rest \
    && cd /fire-rest \
    && pip3 install -r requirements.txt \
    && python3 setup.py install --user \
    && rm -rf .git \
    && rm -f *.md
