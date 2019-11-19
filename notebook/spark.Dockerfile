# pyspark
# 图计算
FROM jupyter/pyspark-notebook

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

# GraphFrames
# https://docs.databricks.com/spark/latest/graph-analysis/graphframes/user-guide-python.html#graphframes-user-guide-py
# 使用conda安装貌似有问题的
# RUN conda install --yes -c crogoz graphframes
# https://graphframes.github.io/graphframes/docs/_site/quick-start.html
# /bin/sh: 1: spark-shell: not found
# RUN spark-shell --packages graphframes:graphframes:0.6.0-spark2.3-s_2.11
# RUN pyspark --packages graphframes:graphframes:0.6.0-spark2.3-s_2.11
USER root
RUN $SPARK_HOME/bin/spark-shell --packages graphframes:graphframes:0.7.0-spark2.4-s_2.11
RUN wget http://dl.bintray.com/spark-packages/maven/graphframes/graphframes/0.7.0-spark2.4-s_2.11/graphframes-0.7.0-spark2.4-s_2.11.jar -qO $SPARK_HOME/jars/graphframes.jar

USER $NB_UID
RUN python -m pip install graphframes


# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm
ENV PYTHONIOENCODING utf-8

# 解决时区问题
ENV TZ "Asia/Shanghai"
