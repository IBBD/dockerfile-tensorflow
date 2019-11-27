FROM registry.cn-hangzhou.aliyuncs.com/ibbd/face:mxnet-cu101-opencv-dlib-py3

# pip install
# 安装server服务相关
RUN pip install \
        pandas \
        joblib \
    && pip install -r https://github.com/ibbd-dev/python-fire-rest/raw/master/requirements.txt \
    && pip install git+https://github.com/ibbd-dev/python-fire-rest.git
