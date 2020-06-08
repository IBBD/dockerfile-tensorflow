# 图像标注工具
FROM node:11.10-slim

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

RUN apt-get update && apt-get -y install git && rm -rf /var/lib/apt/lists/*

RUN mkdir /workspace && \
  cd /workspace && \
  git clone https://github.com/SkalskiP/make-sense.git && \
  cd make-sense && \
  npm install

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm
ENV PYTHONIOENCODING utf-8
# 解决时区问题
ENV TZ "Asia/Shanghai"

WORKDIR /workspace/make-sense

ENTRYPOINT ["npm", "start"]
