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
        tqdm \
    && apt-get install -y \

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
RUN pip3 install mxnet-cu101 gluoncv gluonnlp gluonts
        
# nlp工具
# install jieba, fasttext, gensim, pytext
# https://fasttext.cc/docs/en/support.html
RUN pip3 install jieba jieba-fast gensim \
    && git clone https://github.com/facebookresearch/fastText.git /fastText \
    && cd /fastText \
    && python3 setup.py install 

# install jupyter plugin
# https://github.com/ryantam626/jupyterlab_code_formatter
# TODO 
# Jupyter扩展bamboolib：pandas dataframes图形化操作界面
# jupyterlab_voyager: 对csv等文件数据进行可视化 http://vega.github.io/voyager/
RUN pip3 install \
        ipywidgets \
        witwidget-gpu \
        jupyter_contrib_nbextensions \
        jupyter_nbextensions_configurator \
        jupyterlab \
        jupyterlab_latex \
        jupyterlab_code_formatter \
    # 需要先更新six，否则install witwidget时会报错
    # ImportError: cannot import name 'ensure_str'
    && pip3 install -U six \
    # Activate ipywidgets extension in the environment that runs the notebook server
    && jupyter nbextension install --py --symlink --sys-prefix witwidget \
    && jupyter nbextension enable --py --sys-prefix witwidget \
    && jupyter nbextension enable --py widgetsnbextension --sys-prefix \
    && jupyter contrib nbextension install --user \
    && jupyter nbextensions_configurator enable --user \
    && jupyter serverextension enable --py jupyterlab --sys-prefix \
    # 一些插件依赖与nodejs和npm
    && apt-get install -y nodejs npm \
    && jupyter labextension install @jupyterlab/toc \
    && jupyter labextension install @jupyterlab/latex \
    && jupyter labextension install @ryantam626/jupyterlab_code_formatter \
    && jupyter serverextension enable --py jupyterlab_code_formatter \
    && jupyter labextension install @krassowski/jupyterlab_go_to_definition \
    && jupyter labextension install jupyterlab-spreadsheet \
    && jupyter labextension install jupyterlab_voyager 

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm
ENV PYTHONIOENCODING utf-8

# 解决时区问题
ENV TZ "Asia/Shanghai"
