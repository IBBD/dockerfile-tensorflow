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
RUN pip3 install \
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
# TODO 这里有问题
RUN pip3 install \
        ipywidgets \
        witwidget-gpu \
        jupyter_contrib_nbextensions \
        jupyter_nbextensions_configurator \
    # Activate ipywidgets extension in the environment that runs the notebook server
    && jupyter nbextension install --py --symlink --sys-prefix witwidget \
    && jupyter nbextension enable --py --sys-prefix witwidget \
    && jupyter nbextension enable --py widgetsnbextension --sys-prefix \
    && jupyter contrib nbextension install --user \
    && jupyter nbextensions_configurator enable --user

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm
ENV PYTHONIOENCODING utf-8

# 解决时区问题
ENV TZ "Asia/Shanghai"
