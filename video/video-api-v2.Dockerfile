# Pull base image.
FROM python:3.6-slim

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# install base tools: git, wget, pip...
# install opencv
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        git \
        wget \
        libglib2.0-0 \
        libsm6 \
        libxrender1 \
        python3-dev \
    && wget https://bootstrap.pypa.io/get-pip.py \
    && python3 get-pip.py \
    && rm get-pip.py \
    && python3 -m pip install -U setuptools \
    && python3 -m pip --no-cache-dir install \
        numpy \
        pandas \
        scipy \
        scikit-learn \
        opencv-python \
        opencv-contrib-python==3.4.2.16 \
    && rm -rf /var/lib/apt/lists/*

# install ffmpeg
# add-apt-repository: FileNotFoundError: [Errno 2] No such file or directory: 'gpg': 'gpg'
# apt-get install gnupg
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        gnupg \
        software-properties-common \
    && add-apt-repository ppa:jonathonf/ffmpeg-4 -y \
    # && apt-get update -y \
    # update会导致错误：E: The repository 'http://ppa.launchpad.net/jonathonf/ffmpeg-4/ubuntu focal Release' does not have a Release file.
    && apt-get install -y --no-install-recommends \
        ffmpeg \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*

        
# 安装服务常用包
# moviepy依赖：imageio-ffmpeg
# pydub: https://github.com/jiaaro/pydub, 暂时没有使用
RUN python3 -m pip --no-cache-dir install \
        moviepy \
        imageio-ffmpeg \
        pydub

# install http api and cmd api
RUN python3 -m pip install -r https://github.com/ibbd-dev/python-fire-rest/raw/master/requirements.txt \
    && python3 -m pip install git+https://github.com/ibbd-dev/python-fire-rest.git \
    && python3 -m pip install fire
