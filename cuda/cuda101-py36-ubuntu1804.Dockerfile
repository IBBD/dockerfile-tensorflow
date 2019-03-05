#
# cuda 9.2 and python 3.6 Dockerfile
# see: https://gitlab.com/nvidia/cuda/blob/ubuntu16.04/9.2/base/Dockerfile
# see: https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu&target_version=1804&target_type=deblocal

# Pull base image.
# FROM python:3.6-slim
FROM ubuntu:18.04

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# install python 3.6
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        python3 python3-pip \
        wget \
        git \
    && pip3 install -U pip

RUN wget https://developer.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda-repo-ubuntu1804-10-1-local-10.1.105-418.39_1.0-1_amd64.deb \
    && dpkg -i cuda-repo-ubuntu1804-10-1-local-10.1.105-418.39_1.0-1_amd64.deb \
    && apt-key add /var/cuda-repo-10-1/7fa2af80.pub \
    && apt-get update -y \
    && apt-get install -y cuda

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm

# 解决时区问题
ENV TZ "Asia/Shanghai"
