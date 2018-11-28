FROM registry.cn-hangzhou.aliyuncs.com/ibbd/tensorflow:gpu

RUN apt-get update -y \
    && apt-get install -y cmake

RUN pip --no-cache-dir install \
    jsonschema \
    dlib \
    opencv-python \
    face_recognition \
    moviepy \
    flask_restful

RUN pip --no-cache-dir install git+https://github.com/ibbd-dev/python-fire-rest.git

RUN apt-get remove cmake
