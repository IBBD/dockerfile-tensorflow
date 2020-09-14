#
# dfs Dockerfile
#
# FROM registry.cn-hangzhou.aliyuncs.com/prince/alpine-golang:1.11.5 as builder
FROM golang:1.14

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

ENV VERSION=1.4.0
# apk update; \
# apk add --no-cache --virtual .build-deps git wget; \
RUN set -xe; \
    apt-get update -y; \
    apt-get install -y git wget; \
    cd /go/src/; \
    wget https://github.com/cyy0523xc/go-fastdfs/archive/v$VERSION.tar.gz; \
    tar -zxf v$VERSION.tar.gz; \
    mv go-fastdfs-$VERSION go-fastdfs; \
    cd go-fastdfs; \
    go get; \
    CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o fileserver; \
    ls -lh .;

# 二阶段编译
FROM registry.cn-hangzhou.aliyuncs.com/prince/alpine-bash

COPY --from=builder /go/src/go-fastdfs/fileserver /

ENV INSTALL_DIR /usr/local/go-fastdfs
ENV PATH $PATH:$INSTALL_DIR/
ENV GO_FASTDFS_DIR $INSTALL_DIR/data

RUN set -xe; \
    mkdir -p $GO_FASTDFS_DIR; \
    mkdir -p $GO_FASTDFS_DIR/conf; \
    mkdir -p $GO_FASTDFS_DIR/data; \
    mkdir -p $GO_FASTDFS_DIR/files; \
    mkdir -p $GO_FASTDFS_DIR/log; \
    mkdir -p $INSTALL_DIR; \
    mv /fileserver $INSTALL_DIR/; \
    chmod +x $INSTALL_DIR/fileserver;

WORKDIR $INSTALL_DIR

VOLUME $GO_FASTDFS_DIR

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm
# 解决时区问题
ENV TZ "Asia/Shanghai"

CMD ["fileserver" , "${OPTS}"]
