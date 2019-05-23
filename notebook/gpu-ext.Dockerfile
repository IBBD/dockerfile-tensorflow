FROM registry.cn-hangzhou.aliyuncs.com/ibbd/notebook:gpu

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# 可视化决策树时需要用到
RUN pip3 install pydotplus
