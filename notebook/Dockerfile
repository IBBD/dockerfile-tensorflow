# Python 3.7
# base image: tensorflow-notebook
# add pytorch, jieba, fasttext, gensim, nltk
#

# Pull base image.
FROM jupyter/tensorflow-notebook

LABEL maintainer="Alex Cai <cyy0523xc@gmail.com>"

# conda国内源
# 使用在线编译时可以使用国外节点，则不要开始就设置国内源
# RUN conda config --add channels https://mirrors.ustc.edu.cn/anaconda/pkgs/free/
# RUN conda config --add channels https://mirrors.ustc.edu.cn/anaconda/pkgs/main/
# pip使用阿里云的比较好
# RUN pip3 config set global.index-url https://mirrors.aliyun.com/pypi/simple/
# RUN pip3 config set global.index-url http://mirrors.cloud.tencent.com/pypi/simple
# RUN pip3 config set global.index-url http://pypi.douban.com/simple/
# RUN pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

# update conda
# https://anaconda.org/anaconda/conda
# RUN conda update -n base -qy conda
# RUN conda update -c anaconda -qy conda
RUN conda update --all -y

# 安装pytorch
# RUN conda install --quiet --yes pytorch-cpu torchvision-cpu -c pytorch
RUN conda install --quiet --yes pytorch torchvision torchaudio cpuonly -c pytorch

# install nlp工具
# install jieba, fasttext, gensim
RUN conda install --quiet --yes jieba gensim fasttext

# 附加工具
# yellowbrick: Visual analysis and diagnostic tools to facilitate machine learning model selection. 可视化分析
# FeatureSelector是用于降低机器学习数据集的维数的工具
# yellowbrick \
# Initial quick solve with frozen env failed. Unfreezing env and trying again.
# 保存成excel文件时需要：openpyxl
# networkx: 默认已经有这个
#        pydotplus \
#        python-graphviz \
#        python-igraph \
#        pdf2image \
#        mlflow \
RUN conda install -c conda-forge -y \
        opencv \
        openpyxl \
        fuzzywuzzy \
        python-Levenshtein \
        flashtext

# install 时间序列&关系网络
# RUN conda install -c conda-forge -y fbprophet

# conda国内源
RUN conda config --add channels https://mirrors.ustc.edu.cn/anaconda/pkgs/free/
RUN conda config --add channels https://mirrors.ustc.edu.cn/anaconda/pkgs/main/

# pip国内源
RUN pip3 config set global.index-url https://mirrors.aliyun.com/pypi/simple/

# 原来的用户
USER jovyan

# 配置matplotlib
# ENV matplotlibrc `python3 -c "import matplotlib;print(matplotlib.matplotlib_fname())"`
# /opt/conda/lib/python3.7/site-packages
ENV matplotlibrc /opt/conda/lib/python`python3 -V|sed -r "s/.*?(3\.[0-9]+).*/\1/"`/site-packages/matplotlib/mpl-data/matplotlibrc
ENV mpl_path /opt/conda/lib/python`python3 -V|sed -r "s/.*?(3\.[0-9]+).*/\1/"`/site-packages/matplotlib/mpl-data/fonts/ttf/
ADD ./SimHei.ttf "$mpl_path"
RUN sed -i 's/#font.family/font.family/' "$matplotlibrc" \
    && sed -i 's/#font.sans-serif\s*:/font.sans-serif : SimHei, /' "$matplotlibrc" \
    && sed -i 's/#axes.unicode_minus\s*:\s*True/axes.unicode_minus  : False/' "$matplotlibrc"

# install nbgrader
# https://nbgrader.readthedocs.io/en/stable/user_guide/installation.html

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
