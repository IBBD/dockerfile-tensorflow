FROM registry.cn-hangzhou.aliyuncs.com/ibbd/paddle:kaldi

# 解码器的安装
ENV KALDI_ROOT /opt/kaldi
RUN cd /models/PaddleSpeech/DeepASR/decoder \
    && git clone https://github.com/pybind/pybind11.git \
    && git clone https://github.com/progschj/ThreadPool.git \
    && python3 setup.py build_ext -i 
