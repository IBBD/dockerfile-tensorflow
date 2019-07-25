# Pull base image.
FROM registry.cn-hangzhou.aliyuncs.com/ibbd/cuda:cuda101-cudnn7-py36-ubuntu1804

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# 安装环境依赖
RUN apt-get update -y \
    && apt-get install -y \
        git \
    && rm -rf /var/lib/apt/lists/*

# 安装基础库
RUN python3 -m pip install -U setuptools \
    && python3 -m pip --no-cache-dir install \
        numpy \
        pandas \
        scipy \
        scikit-learn \
        python_speech_features \
        tensorflow-gpu \
        keras 

# 安装服务常用包
RUN python3 -m pip --no-cache-dir install \
        flask \
        flask_jsonrpc \
        fire \
        requests_toolbelt \
        pycrypto \
        jsonschema \
        flask_restful \
        tqdm \
    && python3 -m pip install git+https://github.com/ibbd-dev/python-fire-rest.git 
