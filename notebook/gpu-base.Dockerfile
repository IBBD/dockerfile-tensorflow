# 版本
# latest	TensorFlow CPU 二进制映像的最新版本。默认。
# nightly	TensorFlow 映像的每夜版。（不稳定）
# version	指定 TensorFlow 二进制映像的版本，例如：1.12.0
# devel	TensorFlow master 开发环境的每夜版。包含 TensorFlow 源代码。
# 变体
# tag-gpu	支持 GPU 的指定标记版本。
# tag-py3	支持 Python 3 的指定标记版本。
# tag-jupyter	带有 Jupyter 的指定标记版本（包含 TensorFlow 教程笔记本）
# Dockerfile: https://github.com/tensorflow/tensorflow/blob/master/tensorflow/tools/dockerfiles/dockerfiles/gpu-jupyter.Dockerfile
FROM tensorflow/tensorflow:latest-gpu-py3-jupyter

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# From: https://github.com/jupyter/docker-stacks/blob/master/scipy-notebook/Dockerfile
# No matching distribution found for hdf5: h5py
# auto-sklearn：暂时不安装，该包依赖于旧版本的scikit-lean
# 从python 3.6开始，enum34库不再与标准库兼容。
# attributeerror: module 'enum' has no attribute 'intflag'  
RUN pip3 uninstall -y enum34 \
    && pip3 --no-cache-dir install \
        'pandas' \
        'numexpr' \
        'matplotlib' \
        'scipy' \
        'seaborn' \
        'scikit-learn' \
        'scikit-image' \
        'sympy' \
        'cython' \
        'patsy' \
        'statsmodels' \
        'cloudpickle' \
        'dill' \
        'dask' \
        'numba' \
        'bokeh' \
        'sqlalchemy' \
        'h5py' \
        'vincent' \
        'beautifulsoup4' \
        'protobuf' \
        'xlrd'  \
        'facets'  \
        'tqdm'  \
        'scikit-multilearn'

# install jupyter plugin
# https://github.com/ryantam626/jupyterlab_code_formatter
# TODO 
# Jupyter扩展bamboolib：pandas dataframes图形化操作界面
# jupyterlab_voyager: 对csv等文件数据进行可视化 http://vega.github.io/voyager/
#        ipywidgets \
#        witwidget-gpu \
#        jupyter_contrib_nbextensions \
#        jupyter_nbextensions_configurator \
RUN pip3 --no-cache-dir install \
        jupyterlab 

# install nodejs
# RUN apt-get update -y \
#     && apt-get install -y git curl wget \
#     && wget https://deb.nodesource.com/setup_12.x \
#     && bash setup_12.x \
#     && rm -f setup_12.x \
#     && apt-get install -y nodejs

# https://github.com/krassowski/jupyterlab-lsp
# debugger依赖于：ptvsd,  xeus-python
# RUN pip3 install jupyter-lsp \
#     && jupyter labextension install -y @krassowski/jupyterlab-lsp \
#     && pip3 install python-language-server[all] \
#     && pip3 install --upgrade jupyterlab-git \
#     && jupyter labextension install @jupyterlab/debugger \
#     && pip3 install ptvsd \
#     && pip3 install xeus-python

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm
ENV PYTHONIOENCODING utf-8

# 解决时区问题
ENV TZ "Asia/Shanghai"
