#
# tensorflow Dockerfile
#
#

# Pull base image.
FROM tensorflow/tensorflow

MAINTAINER Alex Cai "cyy0523xc@gmail.com"


# 代码目录
RUN mkdir -p /var/www

# Define working directory.
WORKDIR /var/www

# 解决时区问题
ENV TZ "Asia/Shanghai"
