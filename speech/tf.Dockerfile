#
# tensorflow GPU Dockerfile
#

# Pull base image.
#FROM tensorflow/tensorflow:latest-gpu-py3
FROM tensorflow/tensorflow:1.13.2-gpu-py3 

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

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm

# 解决时区问题
ENV TZ "Asia/Shanghai"
