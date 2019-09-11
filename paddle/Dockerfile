FROM registry.cn-hangzhou.aliyuncs.com/ibbd/cuda:cuda101-cudnn7-py36-ubuntu1804

# https://www.paddlepaddle.org.cn/
RUN pip3 install paddlepaddle-gpu \
    paddlehub

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        git \
        wget \
    && ln -s /usr/bin/python3 /usr/bin/python \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


RUN git clone https://github.com/PaddlePaddle/models /models 
