# 
FROM registry.cn-hangzhou.aliyuncs.com/ibbd/pose:openpose-v1.5-cu102

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install server
RUN git clone https://github.com/ibbd-dev/python-fire-rest /fire-rest \
    && cd /fire-rest \
    && pip3 install -r requirements.txt \
    && pip3 install fire \
    && python3 setup.py install --user \
    && rm -rf /fire-rest

WORKDIR /opt/openpose/

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV LANG C.UTF-8
ENV TERM xterm
ENV PYTHONIOENCODING utf-8
# 解决时区问题
ENV TZ "Asia/Shanghai"
