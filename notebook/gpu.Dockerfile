FROM tensorflow/tensorflow:latest-py3-jupyter

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# 安装pytorch
RUN pip3 install https://download.pytorch.org/whl/cu100/torch-1.0.1.post2-cp35-cp35m-linux_x86_64.whl \
    && pip3 install torchvision

# nlp工具
# install jieba, fasttext
RUN pip3 install jieba \
    && git clone https://github.com/facebookresearch/fastText.git \
    && cd fastText \
    && pip install . \
    && cd .. \
    && rm -rf fastText

# 附加工具
# yellowbrick: Visual analysis and diagnostic tools to facilitate machine learning model selection. 可视化分析
# FeatureSelector是用于降低机器学习数据集的维数的工具
RUN pip3 install \
    districtdatalabs \
    yellowbrick \
    opencv-python \
    opencv-contrib-python 

# 配置文件
# 原配置文件已经备份
# ADD ./jupyter_notebook_config.py /home/jovyan/.jupyter/jupyter_notebook_config.py 

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm
ENV PYTHONIOENCODING utf-8

# 解决时区问题
ENV TZ "Asia/Shanghai"
