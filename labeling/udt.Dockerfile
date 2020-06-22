# 数据标注工具:
# 1. 支持多种数据类型：图像，视频，音频，文本，PDF等
# 2. 支持协作（但是协作功能貌似不强）
# 3. 
# https://github.com/UniversalDataTool/universal-data-tool/

# 编译阶段
FROM node:lts as builder

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

ENV VERSION 0.10.23
RUN apt-get update -y \
    && apt-get install -y wget \
    && mkdir /udt \
    && cd /udt \
    && wget https://github.com/UniversalDataTool/universal-data-tool/archive/v"$VERSION".tar.gz \
    && tar -zxf v"$VERSION".tar.gz \
    && cd universal-data-tool* \
    && npm install \
    && cd .. \
    && rm -f -zxf v"$VERSION".tar.gz \
    && rm -rf /var/lib/apt/lists/*

# 生产阶段
FROM node:lts-slim as prod

COPY --from=0 /udt .

WORKDIR /udt

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm
# ENV PYTHONIOENCODING utf-8

# 解决时区问题
ENV TZ "Asia/Shanghai"
