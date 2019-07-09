# nlp文本标注工具
#

# Pull base image.
FROM chakkiworks/doccano

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# nlp工具
RUN apt-get install -y git \
    && pip install jieba 

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm
ENV PYTHONIOENCODING utf-8

# 解决时区问题
ENV TZ "Asia/Shanghai"
