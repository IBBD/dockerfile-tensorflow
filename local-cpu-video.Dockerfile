FROM registry.cn-hangzhou.aliyuncs.com/ibbd/tensorflow:local-cpu


RUN pip --no-cache-dir install \
    jsonschema \
    dlib \
    opencv-python \
    face_recognition \
    moviepy \
    flask_restful

RUN pip --no-cache-dir install git+https://github.com/ibbd-dev/python-fire-rest.git
