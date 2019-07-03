FROM registry.cn-hangzhou.aliyuncs.com/ibbd/notebook:gpu-base

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# 安装pytorch
# https://pytorch.org/get-started/locally/
#RUN pip3 install https://download.pytorch.org/whl/cu100/torch-1.1.0-cp35-cp35m-linux_x86_64.whl \
    #&& pip3 install torchvision
RUN pip3 install https://download.pytorch.org/whl/cu100/torch-1.1.0-cp36-cp36m-linux_x86_64.whl \
    && pip3 install https://download.pytorch.org/whl/cu100/torchvision-0.3.0-cp36-cp36m-linux_x86_64.whl

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
# pyarrow fastparquet: pandas的parquet需要依赖于这两个包
RUN apt-get update -y \
    && apt-get install -y \
        libglib2.0-0 \
        libsm6 \
        libxrender1 \
        python3-pydot \
        python3-pygraphviz \
        imagemagick \
    && pip3 install \
        yellowbrick \
        opencv-python \
        opencv-contrib-python \
        keras \
        pydotplus \
        graphviz \
        prettytable \
        pyarrow fastparquet \
    && rm -rf /var/lib/apt/lists/*

# 扩展算法包
# 时间序列
# fbprophet依赖与pystan
# 机器学习的可解释性
# eli5: 对各类机器学习模型进行可视化，特征重要度计算等
# pdpbox: 展示一个或者两个特征对于模型的边际效应
# shap: 细分预测以显示每个特征的影响
RUN pip3 install pystan fbprophet \
    && pip3 install eli5 PDPbox shap \
    && pip3 install xgboost \
        lightgbm \
        catboost \
        sklearn-contrib-lightning

# 配置文件
# 原配置文件已经备份
# ADD ./jupyter_notebook_config.py /home/jovyan/.jupyter/jupyter_notebook_config.py 

# 配置matplotlib
#ENV matplotlibrc `python3 -c "import matplotlib;print(matplotlib.matplotlib_fname())"`
ENV matplotlibrc /usr/local/lib/python3.6/dist-packages/matplotlib/mpl-data/matplotlibrc
ENV mpl_path /usr/local/lib/python3.6/dist-packages/matplotlib/mpl-data/fonts/ttf/
ADD ./SimHei.ttf "$mpl_path"
RUN sed -i 's/#font.family/font.family/' "$matplotlibrc" \
    && sed -i 's/#font.sans-serif\s*:/font.sans-serif : SimHei, /' "$matplotlibrc" \
    && sed -i 's/#axes.unicode_minus\s*:\s*True/axes.unicode_minus  : False/' "$matplotlibrc" 
