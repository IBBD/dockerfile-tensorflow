#
# 深度学习Notebook镜像
# 
FROM registry.cn-hangzhou.aliyuncs.com/ibbd/cuda:cuda101-cudnn7-py36-ubuntu1804

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# From: https://github.com/jupyter/docker-stacks/blob/master/scipy-notebook/Dockerfile
# No matching distribution found for hdf5: h5py
# auto-sklearn：暂时不安装，该包依赖于旧版本的scikit-lean
RUN pip3 install \
        numpy \
        pandas \
        matplotlib \
        scipy \
        scikit-learn \
        cython \
        numba \
        sqlalchemy \
        h5py \
        tqdm 

# opencv
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        libglib2.0-0 \
        libsm6 \
        libxrender1 \
    && pip3 install opencv-python \
    && rm -rf /var/lib/apt/lists/*

# install tensorflow
RUN pip3 install tensorflow-gpu keras 

# install pytorch 1.2
# flair: https://github.com/zalandoresearch/flair
# Flair是一个基于PyTorch构建的NLP开发包，它在解决命名实体识别（NER）、部分语音标注（PoS）、语义消歧和文本分类等NLP问题达到了当前的最高水准。
RUN pip3 install torch torchvision pytext-nlp flair

# install PaddlePaddle
# https://www.paddlepaddle.org.cn/
RUN pip3 install paddlepaddle-gpu

# mxnet
# gluonts 0.3.3 has requirement numpy==1.14.*, but you'll have numpy 1.17.2 which is incompatible.
RUN pip3 install mxnet-cu101 gluoncv gluonnlp gluonts
        
# nlp工具
# install jieba, fasttext, gensim, pytext
# https://fasttext.cc/docs/en/support.html
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        git \
    && pip3 install jieba jieba-fast gensim \
    && git clone https://github.com/facebookresearch/fastText.git /fastText \
    && cd /fastText \
    && python3 setup.py install \
    && rm -rf /var/lib/apt/lists/*

# install jupyter 
RUN pip3 install jupyterlab

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm
ENV PYTHONIOENCODING utf-8

# 解决时区问题
ENV TZ "Asia/Shanghai"
