FROM registry.cn-hangzhou.aliyuncs.com/ibbd/notebook:gpu

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# 配置matplotlib
#ENV matplotlibrc `python3 -c "import matplotlib;print(matplotlib.matplotlib_fname())"`
ENV matplotlibrc /usr/local/lib/python3.5/dist-packages/matplotlib/mpl-data/matplotlibrc
ENV mpl_path $(echo $matplotlibrc|sed 's/matplotlibrc//')
COPY ./SimHei.ttf "$mpl_path"fonts/ttf/Vera.ttf
RUN sed -i 's/#font.serif/font.serif/' "$matplotlibrc"
