# pyspark
FROM jupyter/pyspark-notebook

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# GraphFrames
# https://docs.databricks.com/spark/latest/graph-analysis/graphframes/user-guide-python.html#graphframes-user-guide-py
RUN conda install -c crogoz graphframes

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm
ENV PYTHONIOENCODING utf-8

# 解决时区问题
ENV TZ "Asia/Shanghai"
