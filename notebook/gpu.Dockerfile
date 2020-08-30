# 在Tensorflow Notebook常用的包的基础上加装：
# 1. nlp类：jieba, gensim, fastText, pytext
# 2. 时间序列：prophet
# 3. 模型可解释性：eli5, pdpbox, shap
# 4. xgboost, lightgbm, catboost, lightnig
# 5. pytorch, keras
# 6. opencv
# 7. 图关系：networkx, igraph
# 8. 其他：sk-disk
# 9. pytorch, paddlepaddle
FROM registry.cn-hangzhou.aliyuncs.com/ibbd/notebook:gpu-base

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# 安装pytorch
# https://pytorch.org/get-started/locally/
#RUN pip3 install https://download.pytorch.org/whl/cu100/torch-1.1.0-cp35-cp35m-linux_x86_64.whl \
    #&& pip3 install torchvision
# RUN pip3 install https://download.pytorch.org/whl/cu100/torch-1.1.0-cp36-cp36m-linux_x86_64.whl \
    # && pip3 install https://download.pytorch.org/whl/cu100/torchvision-0.3.0-cp36-cp36m-linux_x86_64.whl
# install pytorch 1.2
# RUN pip3 install torch torchvision
# visdom: 可视化
# thop: 模型参数及计算量统计
# RUN pip3 install torch==1.5.0+cu101 torchvision==0.6.0+cu101 -f https://download.pytorch.org/whl/torch_stable.html \
# torchcontrib: https://github.com/pytorch/contrib
# RUN pip3 --no-cache-dir install torch==1.6.0+cu101 torchvision==0.7.0+cu101 -f https://download.pytorch.org/whl/torch_stable.html \
# Cupy: https://github.com/cupy/cupy
RUN pip3 --no-cache-dir install torch torchvision \
    && pip3 --no-cache-dir install cupy-cuda102 \
    && pip3 --no-cache-dir install visdom thop torchcontrib \

# Paddle独立成一个单独的Notebook
# install PaddlePaddle
# https://www.paddlepaddle.org.cn/
# RUN pip3 install paddlepaddle-gpu

# 附加工具
# yellowbrick: Visual analysis and diagnostic tools to facilitate machine learning model selection. 可视化分析
# FeatureSelector是用于降低机器学习数据集的维数的工具
# pydotplus, graphviz: 可视化决策树时需要用到
# PrettyTable模块可以将输出内容如表格方式整齐地输出
# pyarrow fastparquet: pandas的parquet需要依赖于这两个包
# igraph依赖：build-essential libxml2 libxml2-dev zlib1g-dev
# https://github.com/igraph/python-igraph
# datasketch这个模块有非常多的功能，主要是：
# HyperLogLog
# HyperLogLog++
# MinHash LSH
# MinHash LSH Ensemble
# MinHash LSH Forest
# MinHash
# Weighted MinHash
# pdf2image依赖与poppler-utils
# keras已经内置在tf中
# 网络关系挖掘包：networkx python-igraph 
# graphviz实际上是一个绘图工具，可以根据dot脚本画出树形图等
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        build-essential \
        git \
        curl \
        libxml2 \
        libxml2-dev \
        zlib1g-dev \
        libglib2.0-0 \
        libsm6 \
        libxrender1 \
        python3-pydot \
        python3-pygraphviz \
        imagemagick \
        htop \
        poppler-utils \
        ffmpeg dvipng \
    && pip3 --no-cache-dir install \
        yellowbrick \
        opencv-python \
        opencv-contrib-python \
        pydotplus \
        graphviz \
        prettytable \
        pyarrow fastparquet \
        sk-dist \
        datasketch \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# nlp工具
# install jieba, fasttext, gensim, pytext
# https://fasttext.cc/docs/en/support.html
# flair: https://github.com/zalandoresearch/flair
# Flair是一个基于PyTorch构建的NLP开发包，它在解决命名实体识别（NER）、部分语音标注（PoS）、语义消歧和文本分类等NLP问题达到了当前的最高水准。
RUN pip3 --no-cache-dir install jieba jieba-fast gensim \
    && git clone https://github.com/facebookresearch/fastText.git /fastText \
    && cd /fastText \
    && python3 setup.py install \
    && cd / \
    && rm -rf /fastText

# 扩展算法包
# 时间序列
# fbprophet依赖与pystan
# 机器学习的可解释性
# eli5: 对各类机器学习模型进行可视化，特征重要度计算等
# pdpbox: 展示一个或者两个特征对于模型的边际效应
# shap: 细分预测以显示每个特征的影响
# hdbscan: https://hdbscan.readthedocs.io/en/latest/basic_hdbscan.html
# PyCaret 库支持数据科学家快速高效地执行端到端实验，PyCaret 库只需几行代码即可执行复杂的机器学习任务
# tensorflow-model-optimization: tf模型优化工具
# NNI: https://nni.readthedocs.io/zh/latest/Compressor/QuickStart.html
# NNI: https://github.com/microsoft/nni/blob/master/examples/model_compress/model_prune_torch.py
# NNI: 提供了并行运行多个实例以查找最佳参数组合的能力。 此功能可用于各种领域，例如，为深度学习模型查找最佳超参数，或查找具有真实数据的数据库和其他复杂系统的最佳配置。
# NNI: 还希望提供用于机器学习和深度学习的算法工具包，尤其是神经体系结构搜索（NAS）算法，模型压缩算法和特征工程算法。
# https://github.com/betatim/notebook-as-pdf and pyppeteer-install
# 保存成excel文件时需要：openpyxl
#        notebook-as-pdf \
#    && pyppeteer-install
RUN pip3 --no-cache-dir install convertdate pystan fbprophet \
    && pip3 --no-cache-dir install eli5 PDPbox shap \
    && pip3 --no-cache-dir install xgboost \
        lightgbm \
        catboost \
        sklearn-contrib-lightning \
        joblib \
        pdf2image \
        pycaret \
        mlflow \
        pdf4py \
        openpyxl \
        fuzzywuzzy \
        python-Levenshtein \
        diff-match-patch \
        pypdf4 \
        tensorflow-model-optimization \
        nni

# 安装ocr工具
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        tesseract-ocr \
        tesseract-ocr-chi-sim \
        tesseract-ocr-chi-tra \
    && rm -rf /var/lib/apt/lists/* \
    && pip3 --no-cache-dir install pytesseract

COPY ./chi_sim_best.traineddata /usr/share/tesseract-ocr/4.00/tessdata/chi_sim_best.traineddata

# 安装自有工具
RUN pip3 --no-cache-dir install -r https://github.com/ibbd-dev/python-ibbd-algo/raw/master/requirements.txt \
    && pip3 --no-cache-dir install git+https://github.com/ibbd-dev/python-ibbd-algo.git \
    && pip3 --no-cache-dir install -r https://github.com/ibbd-dev/python-image-utils/raw/master/requirements.txt \
    && pip3 --no-cache-dir install git+https://github.com/ibbd-dev/python-image-utils.git \
    && pip3 --no-cache-dir install -r https://github.com/ibbd-dev/python-fire-rest/raw/master/requirements.txt \
    && pip3 --no-cache-dir install git+https://github.com/ibbd-dev/python-fire-rest.git

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

# fix
# ModuleNotFoundError: No module named 'keyring.util.escape'
RUN pip3 install --upgrade pip \
    && pip3 install --upgrade keyrings.alt 

CMD ["bash", "-c", "source /etc/bash.bashrc && jupyter lab --notebook-dir=/tf --ip 0.0.0.0 --no-browser --allow-root"]
