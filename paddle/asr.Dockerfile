FROM registry.cn-hangzhou.aliyuncs.com/ibbd/paddle:latest

# kaldi的安装
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        g++ \
        make \
        automake \
        autoconf \
        sox \
        libtool \
        zlib1g-dev \
        patch \
        ffmpeg \
        bzip2 \
        unzip \
        ca-certificates \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/python3 /usr/bin/python 
RUN git clone https://github.com/kaldi-asr/kaldi.git /opt/kaldi \
    && cd /opt/kaldi \
    && cd /opt/kaldi/tools \
    && ./extras/install_mkl.sh \
    && make -j $(nproc) \
    && cd /opt/kaldi/src \
    && ./configure --shared --use-cuda \
    && make depend -j $(nproc) \
    && make -j $(nproc)

# 解码器的安装
ENV KALDI_ROOT /opt/kaldi
RUN cd /models/fluid/DeepASR/decoder \
    && sh setup.sh
