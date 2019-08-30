# Pull base image.
FROM cagdasbas/openpose-gpu:1.4-10.0-cudnn7-runtime

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

ADD scripts/openpose_image.py /opt/openpose/python/openpose/
ADD scripts/openpose_video.py /opt/openpose/python/openpose/

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install server
RUN git clone https://github.com/ibbd-dev/python-fire-rest /fire-rest \
    && cd /fire-rest \
    && pip3 install -r requirements.txt \
    && python3 setup.py install --user \
    && rm -rf .git \
    && rm -f *.md

WORKDIR /opt/openpose/python/openpose

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV LANG C.UTF-8
ENV TERM xterm
ENV PYTHONIOENCODING utf-8
# 解决时区问题
ENV TZ "Asia/Shanghai"
