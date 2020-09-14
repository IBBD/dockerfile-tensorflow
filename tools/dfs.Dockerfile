#
# dfs Dockerfile
#
FROM registry.cn-hangzhou.aliyuncs.com/prince/alpine-bash

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

ENV VERSION=1.4.0
ENV INSTALL_DIR /dfs
ENV PATH $PATH:$INSTALL_DIR/
ENV GO_FASTDFS_DIR $INSTALL_DIR/data

RUN apk update \
    && apk --no-cache add wget \
    && mkdir -p $GO_FASTDFS_DIR \
    && mkdir -p $GO_FASTDFS_DIR/conf \
    && mkdir -p $GO_FASTDFS_DIR/data \
    && mkdir -p $GO_FASTDFS_DIR/files \
    && mkdir -p $GO_FASTDFS_DIR/log \
    && mkdir -p $INSTALL_DIR \
    && cd $INSTALL_DIR/ \
    && wget https://github.com/sjqzhang/go-fastdfs/releases/download/v$VERSION/fileserver \
    && chmod +x $INSTALL_DIR/fileserver

WORKDIR $INSTALL_DIR

VOLUME $GO_FASTDFS_DIR

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm
# 解决时区问题
ENV TZ "Asia/Shanghai"

CMD ["fileserver" , "${OPTS}"]
