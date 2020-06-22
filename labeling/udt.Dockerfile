# 数据标注工具
# https://github.com/UniversalDataTool/universal-data-tool/

FROM node:lts

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

ENV VERSION 0.10.23
RUN apt-get update -y \
    && apt-get install -y wget unzip \
    && mkdir /udt \
    && cd /udt \
    && wget https://github.com/UniversalDataTool/universal-data-tool/archive/v"$VERSION".tar.gz \
    && tar -zxf v"$VERSION".tar.gz \
    && cd universal-data-tool* \
    && npm install 

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm
ENV PYTHONIOENCODING utf-8

# 解决时区问题
ENV TZ "Asia/Shanghai"
