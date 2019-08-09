# Python 3.7
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
RUN conda install --quiet --yes jieba gensim prettytable fasttext 

# 附加工具
# yellowbrick: Visual analysis and diagnostic tools to facilitate machine learning model selection. 可视化分析
# FeatureSelector是用于降低机器学习数据集的维数的工具
# yellowbrick \
RUN conda install -c \
        districtdatalabs \
        opencv \
        pydotplus \
        python-graphviz \
    && conda install pyarrow -c conda-forge \
    && conda install fastparquet -c conda-forge

# 时间序列
RUN conda install -c conda-forge fbprophet

# 配置matplotlib
#ENV matplotlibrc `python3 -c "import matplotlib;print(matplotlib.matplotlib_fname())"`
# /opt/conda/lib/python3.7/site-packages
# ENV matplotlibrc /usr/local/lib/python3.5/dist-packages/matplotlib/mpl-data/matplotlibrc
# ENV mpl_path /usr/local/lib/python3.5/dist-packages/matplotlib/mpl-data/fonts/ttf/
ENV matplotlibrc /opt/conda/lib/python3.7/site-packages/matplotlib/mpl-data/matplotlibrc
ENV mpl_path /opt/conda/lib/python3.7/site-packages/matplotlib/mpl-data/fonts/ttf/
ADD ./SimHei.ttf "$mpl_path"
RUN sed -i 's/#font.family/font.family/' "$matplotlibrc" \
    && sed -i 's/#font.sans-serif\s*:/font.sans-serif : SimHei, /' "$matplotlibrc" \
    && sed -i 's/#axes.unicode_minus\s*:\s*True/axes.unicode_minus  : False/' "$matplotlibrc" 

# nbgrader
# https://nbgrader.readthedocs.io/en/stable/user_guide/installation.html
RUN conda install -c conda-forge nbgrader \
    && jupyter nbextension install --sys-prefix --py nbgrader --overwrite \
    && jupyter nbextension enable --sys-prefix --py nbgrader \
    && jupyter serverextension enable --sys-prefix --py nbgrader

# 配置文件
# 原配置文件已经备份
#RUN cp .jupyter/jupyter_notebook_config.py .jupyter/jupyter_notebook_config.py.bak
#ADD ./config/jupyter_notebook_config.py /home/jovyan/.jupyter/jupyter_notebook_config.py 

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm
ENV PYTHONIOENCODING utf-8

# 解决时区问题
ENV TZ "Asia/Shanghai"
