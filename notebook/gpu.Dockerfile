FROM tensorflow/tensorflow:latest-py3-jupyter

MAINTAINER Alex Cai "cyy0523xc@gmail.com"


# 配置文件
# 原配置文件已经备份
ADD ./jupyter_notebook_config.py /home/jovyan/.jupyter/jupyter_notebook_config.py 

# 终端设置
# 默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm
ENV PYTHONIOENCODING utf-8

# 解决时区问题
ENV TZ "Asia/Shanghai"
