FROM registry.cn-hangzhou.aliyuncs.com/ibbd/notebook:gpu

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# 配置matplotlib
#ENV matplotlibrc `python3 -c "import matplotlib;print(matplotlib.matplotlib_fname())"`
ENV matplotlibrc /usr/local/lib/python3.5/dist-packages/matplotlib/mpl-data/matplotlibrc
ENV mpl_path /usr/local/lib/python3.5/dist-packages/matplotlib/mpl-data/
ADD ./SimHei.ttf "$mpl_path"fonts/ttf/SimHei.ttf
RUN sed -i 's/#font.family/font.family/' "$matplotlibrc" \
    && sed -i 's/#font.sans-serif\s*:/font.sans-serif : SimHei, /' "$matplotlibrc" \
    && sed -i 's/#axes.unicode_minus\s*:\s*True/axes.unicode_minus  : False/' "$matplotlibrc" 
