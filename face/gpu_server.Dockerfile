FROM registry.cn-hangzhou.aliyuncs.com/ibbd/face:mxnet-cu90-opencv-dlib-py3

# pip install
# 安装server服务相关
# json-tricks: json格式化使用
RUN pip install \
        easydict \
        flask \
        flask_restful \
        jsonschema \
        json-tricks \
    && pip install git+https://github.com/ibbd-dev/python-fire-rest.git
