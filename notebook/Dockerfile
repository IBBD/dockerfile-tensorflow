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
RUN conda install --quiet --yes jieba gensim prettytable \
    && git clone https://github.com/facebookresearch/fastText.git \
    && cd fastText \
    && pip install . \
    && cd .. \
    && rm -rf fastText \
    && cp .jupyter/jupyter_notebook_config.py .jupyter/jupyter_notebook_config.py.bak

# 附加工具
# yellowbrick: Visual analysis and diagnostic tools to facilitate machine learning model selection. 可视化分析
# FeatureSelector是用于降低机器学习数据集的维数的工具
# yellowbrick \
RUN conda install -c \
    districtdatalabs \
    opencv \
    pydotplus

# 配置文件
# 原配置文件已经备份
ADD ./jupyter_notebook_config.py /home/jovyan/.jupyter/jupyter_notebook_config.py 

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm
ENV PYTHONIOENCODING utf-8

# 解决时区问题
ENV TZ "Asia/Shanghai"
