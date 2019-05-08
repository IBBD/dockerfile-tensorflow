FROM tensorflow/tensorflow:latest-gpu-py3-jupyter

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# From: https://github.com/jupyter/docker-stacks/blob/master/scipy-notebook/Dockerfile
RUN pip3 install \
        'ipywidgets=7.4*' \
        'pandas=0.24*' \
        'numexpr=2.6*' \
        'matplotlib=3.0*' \
        'scipy=1.2*' \
        'seaborn=0.9*' \
        'scikit-learn=0.20*' \
        'scikit-image=0.14*' \
        'sympy=1.3*' \
        'cython=0.29*' \
        'patsy=0.5*' \
        'statsmodels=0.9*' \
        'cloudpickle=0.8*' \
        'dill=0.2*' \
        'dask=1.1.*' \
        'numba=0.42*' \
        'bokeh=1.0*' \
        'sqlalchemy=1.3*' \
        'hdf5=1.10*' \
        'h5py=2.9*' \
        'vincent=0.4.*' \
        'beautifulsoup4=4.7.*' \
        'protobuf=3.7.*' \
        'xlrd'  \
    # Activate ipywidgets extension in the environment that runs the notebook server
    && jupyter nbextension enable --py widgetsnbextension --sys-prefix \
    # Also activate ipywidgets extension for JupyterLab
    # Check this URL for most recent compatibilities
    # https://github.com/jupyter-widgets/ipywidgets/tree/master/packages/jupyterlab-manager
    && jupyter labextension install @jupyter-widgets/jupyterlab-manager@^0.38.1 \
    && jupyter labextension install jupyterlab_bokeh@0.6.3

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm
ENV PYTHONIOENCODING utf-8

# 解决时区问题
ENV TZ "Asia/Shanghai"
