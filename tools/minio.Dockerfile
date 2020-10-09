#
# minio Dockerfile
#
FROM minio/minio

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm
# 解决时区问题
ENV TZ "Asia/Shanghai"
