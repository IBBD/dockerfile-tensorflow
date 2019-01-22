FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04
LABEL maintainer Aaron "wanglj@ibbd.net"

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        cuda-cublas-dev-10-0 \
        cuda-cudart-dev-10-0 \
        cuda-cufft-dev-10-0 \
        cuda-curand-dev-10-0 \
        cuda-cusolver-dev-10-0 \
        cuda-cusparse-dev-10-0 \
        libcurl3-dev \
        libfreetype6-dev \
        libhdf5-serial-dev \
        libpng12-dev \
        libzmq3-dev \
        pkg-config \
        rsync \
        software-properties-common \
        unzip \
        zip \
        zlib1g-dev \
        wget \
        git \
        && \
    find /usr/local/cuda-10.0/lib64/ -type f -name 'lib*_static.a' -not -name 'libcudart_static.a' -delete && \
    rm /usr/lib/x86_64-linux-gnu/libcudnn_static_v7.a

RUN apt-get update && \
        apt-get install nvinfer-runtime-trt-repo-ubuntu1604-5.0.2-ga-cuda10.0 \
        && apt-get update \
        && apt-get install -y --no-install-recommends libnvinfer-dev=5.0.2-1+cuda10.0 \
        && rm -rf /var/lib/apt/lists/*

# Configure the build for our CUDA configuration.
ENV LD_LIBRARY_PATH /usr/local/cuda/extras/CUPTI/lib64:$LD_LIBRARY_PATH


# Install dependencies
RUN apt-get update -y && \
    apt-get install -y build-essential cmake cmake-curses-gui wget unzip git libavcodec-dev libavutil-dev libavutil-ffmpeg54 libavformat-dev libavfilter-dev libavdevice-dev libjpeg8-dev libpng16-dev libtiff5-dev libx264-dev libgstreamer1.0-dev libboost-all-dev && \
    apt-get install -y libopenblas-dev liblapack-dev qt5-default libqt5svg5-dev qtcreator libqt5serialport5-dev qtmultimedia5-dev 
    
# Casa Blanca and DocumentDBCpp dependencies
RUN apt-get install -y libcpprest-dev libssl-dev uuid-dev && \
    apt-get clean -y
