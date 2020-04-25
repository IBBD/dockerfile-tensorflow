# Python 3.7
# base image: tensorflow-notebook
# add pytorch, jieba, fasttext, gensim, nltk
#

# Pull base image.
FROM jupyter/tensorflow-notebook

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# update conda
# https://anaconda.org/anaconda/conda
# RUN conda update -n base -qy conda
# RUN conda update -c anaconda -qy conda
RUN conda update --all -y

# 安装pytorch
RUN conda install --quiet --yes pytorch-cpu torchvision-cpu -c pytorch

# install nlp工具
# install jieba, fasttext, gensim, nltk
RUN conda install --quiet --yes jieba gensim prettytable fasttext nltk

# 附加工具
# yellowbrick: Visual analysis and diagnostic tools to facilitate machine learning model selection. 可视化分析
# FeatureSelector是用于降低机器学习数据集的维数的工具
# yellowbrick \
# Initial quick solve with frozen env failed. Unfreezing env and trying again.
RUN conda install -c conda-forge -y \
        opencv \
        pydotplus \
        python-graphviz \
        networkx \
        python-igraph \
        pdf2image \
        mlflow \
    && conda install -c conda-forge -y pyarrow fastparquet

# install 时间序列&关系网络
RUN conda install -c conda-forge -y fbprophet networkx

# 安装ocr时报错:
# List directory /var/lib/apt/lists/partial is missing. - Acquire (13: Permission denied)
USER root

# 安装ocr工具
RUN apt-get update -y \
    && apt-get install -y \
        tesseract-ocr \
        tesseract-ocr-chi-sim \
        tesseract-ocr-chi-tra \
    && rm -rf /var/lib/apt/lists/* \
    && conda install -c conda-forge -y tesseract

COPY ./chi_sim_best.traineddata /usr/share/tesseract-ocr/4.00/tessdata/chi_sim_best.traineddata

# 配置matplotlib
# ENV matplotlibrc `python3 -c "import matplotlib;print(matplotlib.matplotlib_fname())"`
# /opt/conda/lib/python3.7/site-packages
# ENV matplotlibrc /usr/local/lib/python3.5/dist-packages/matplotlib/mpl-data/matplotlibrc
# ENV mpl_path /usr/local/lib/python3.5/dist-packages/matplotlib/mpl-data/fonts/ttf/
ENV matplotlibrc /opt/conda/lib/python3.7/site-packages/matplotlib/mpl-data/matplotlibrc
ENV mpl_path /opt/conda/lib/python3.7/site-packages/matplotlib/mpl-data/fonts/ttf/
ADD ./SimHei.ttf "$mpl_path"
RUN sed -i 's/#font.family/font.family/' "$matplotlibrc" \
    && sed -i 's/#font.sans-serif\s*:/font.sans-serif : SimHei, /' "$matplotlibrc" \
    && sed -i 's/#axes.unicode_minus\s*:\s*True/axes.unicode_minus  : False/' "$matplotlibrc" 

# install nbgrader
# https://nbgrader.readthedocs.io/en/stable/user_guide/installation.html
# RUN conda install -c conda-forge -y nbgrader \
    # && jupyter nbextension install --sys-prefix --py nbgrader --overwrite \
    # && jupyter nbextension enable --sys-prefix --py nbgrader \
    # && jupyter serverextension enable --sys-prefix --py nbgrader

# 配置文件
# 原配置文件已经备份
# RUN cp .jupyter/jupyter_notebook_config.py .jupyter/jupyter_notebook_config.py.bak
# ADD ./config/jupyter_notebook_config.py /home/jovyan/.jupyter/jupyter_notebook_config.py

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm
ENV PYTHONIOENCODING utf-8

# 解决时区问题
ENV TZ "Asia/Shanghai"
