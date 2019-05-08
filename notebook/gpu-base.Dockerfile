FROM tensorflow/tensorflow:latest-gpu-py3-jupyter

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# From: https://github.com/jupyter/docker-stacks/blob/master/scipy-notebook/Dockerfile
# No matching distribution found for hdf5: h5py
RUN pip3 install \
        'ipywidgets' \
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
    # Activate ipywidgets extension in the environment that runs the notebook server
    && jupyter nbextension enable --py widgetsnbextension --sys-prefix 

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm
ENV PYTHONIOENCODING utf-8

# 解决时区问题
ENV TZ "Asia/Shanghai"
