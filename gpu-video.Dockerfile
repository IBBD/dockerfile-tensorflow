FROM registry.cn-hangzhou.aliyuncs.com/ibbd/tensorflow:gpu

# opencv依赖libsm6, libxext6
RUN apt-get update -y \
    && apt-get install -y cmake git \
    && apt-get install -y libsm6 libxext6

RUN pip --no-cache-dir install \
    jsonschema \
    dlib \
    opencv-python \
    face_recognition \
    moviepy \
    flask_restful

RUN pip --no-cache-dir install git+https://github.com/ibbd-dev/python-fire-rest.git

RUN apt-get remove -y cmake git 

