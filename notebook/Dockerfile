#
# base image: tensorflow-notebook
# add pytorch, jieba, fasttext, nltk
#

# Pull base image.
FROM jupyter/tensorflow-notebook

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# 安装pytorch
RUN conda install --quiet --yes pytorch-cpu torchvision-cpu -c pytorch

# nlp工具
# install jieba, fasttext
RUN conda install --quiet --yes jieba \
    && cd /home/jovyan \
    && git clone https://github.com/facebookresearch/fastText.git \
    && cd fastText \
    && pip install . \
    && cd .. \
    && rm -rf fastText

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm

# 解决时区问题
ENV TZ "Asia/Shanghai"
