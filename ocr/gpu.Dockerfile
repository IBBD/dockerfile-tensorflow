#
# tensorflow gpu Dockerfile
#

# Pull base image.
FROM registry.cn-hangzhou.aliyuncs.com/ibbd/ocr:cpu

# 安装基础库
RUN pip --no-cache-dir install \
        tensorflow-gpu==1.8 

