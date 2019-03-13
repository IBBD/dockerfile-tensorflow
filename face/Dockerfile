#
# base image: tensorflow-notebook
# add pytorch, jieba, fasttext, nltk
#

# Pull base image.
FROM ubuntu:16.04

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# install base
RUN apt-get update -y \
    && apt-get install -y wget python python-pip gcc git

# pip install
RUN pip install scipy scikit-learn mxnet

# insightface
RUN mkdir /face \
    && cd face \
    && git clone --recursive https://github.com/deepinsight/insightface.git

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm

# 解决时区问题
ENV TZ "Asia/Shanghai"
