FROM registry.cn-hangzhou.aliyuncs.com/ibbd/tensorflow:intel-cpu

# opencv依赖libsm6, libxext6
# 对视频的操作需要ffmpeg(直接安装失败)
# 默认保存路径: /home/alex/.imageio/ffmpeg/ffmpeg-linux64-v3.3.1.
ADD data/ffmpeg-linux64-v3.3.1 /root/.imageio/ffmpeg/
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

# 移除不必要的依赖
RUN apt-get remove -y cmake git 

