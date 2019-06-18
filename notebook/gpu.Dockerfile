FROM registry.cn-hangzhou.aliyuncs.com/ibbd/notebook:gpu-base

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# 安装pytorch
# https://pytorch.org/get-started/locally/
RUN pip3 install https://download.pytorch.org/whl/cu100/torch-1.1.0-cp35-cp35m-linux_x86_64.whl \
    && pip3 install torchvision

# nlp工具
# install jieba, fasttext, gensim
RUN apt-get update -y \
    && apt-get install -y git \
    && pip3 install jieba gensim \
    && git clone https://github.com/facebookresearch/fastText.git \
    && cd fastText \
    && pip install . \
    && cd .. \
    && rm -rf fastText \
    && rm -rf /var/lib/apt/lists/*

# 附加工具
# yellowbrick: Visual analysis and diagnostic tools to facilitate machine learning model selection. 可视化分析
# FeatureSelector是用于降低机器学习数据集的维数的工具
# pydotplus, graphviz: 可视化决策树时需要用到
# PrettyTable模块可以将输出内容如表格方式整齐地输出
RUN apt-get update -y \
    && apt-get install -y \
        libglib2.0-0 \
        libsm6 \
        libxrender1 \
        python3-pydot \
        python3-pygraphviz \
    && pip3 install \
        yellowbrick \
        opencv-python \
        opencv-contrib-python \
        keras \
        pydotplus \
        graphviz \
        prettytable \
    && rm -rf /var/lib/apt/lists/*

# 时间序列
RUN pip3 install fbprophet

# 配置文件
# 原配置文件已经备份
# ADD ./jupyter_notebook_config.py /home/jovyan/.jupyter/jupyter_notebook_config.py 

# 配置matplotlib
#ENV matplotlibrc `python3 -c "import matplotlib;print(matplotlib.matplotlib_fname())"`
ENV matplotlibrc /usr/local/lib/python3.5/dist-packages/matplotlib/mpl-data/matplotlibrc
ENV mpl_path /usr/local/lib/python3.5/dist-packages/matplotlib/mpl-data/fonts/ttf/
ADD ./SimHei.ttf "$mpl_path"
RUN sed -i 's/#font.family/font.family/' "$matplotlibrc" \
    && sed -i 's/#font.sans-serif\s*:/font.sans-serif : SimHei, /' "$matplotlibrc" \
    && sed -i 's/#axes.unicode_minus\s*:\s*True/axes.unicode_minus  : False/' "$matplotlibrc" 
