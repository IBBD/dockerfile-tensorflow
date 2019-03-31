FROM registry.cn-hangzhou.aliyuncs.com/ibbd/face:mxnet-cu90-opencv-dlib-py3

# pip install
# 安装server服务相关
RUN pip3 install \
        easydict \
        flask \
        flask_restful \
        jsonschema \
    && pip3 install git+https://github.com/ibbd-dev/python-fire-rest.git
