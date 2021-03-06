# 
# OpenPose v1.5
# OpenPose v1.5.1: 20190910, 只是修改版本号
# OpenPose v1.5.1 with cuda10.2: 20200912, cuda更新到10.2
# 
# 参考：https://github.com/cagdasbas/openpose-gpu/blob/master/openpose-1.4_10.1-cudnn7-runtime/Dockerfile
FROM nvidia/cuda:10.2-cudnn7-devel as build

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# Get the dependencies
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    ca-certificates curl git vim less wget \
    build-essential pkg-config python3-dev libopencv-dev libprotobuf-dev \
    libleveldb-dev libsnappy-dev libhdf5-serial-dev protobuf-compiler \
    libboost-all-dev libatlas-base-dev libgoogle-glog-dev liblmdb-dev libgflags-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# For some reason Ubuntu 18.04 cmake 10.2 cannot compile OpenPose, we need cmake 3.15.2
WORKDIR /
ENV OP_VER 1.5.1
RUN wget https://github.com/Kitware/CMake/releases/download/v3.15.2/cmake-3.15.2-Linux-x86_64.tar.gz && \
    tar xf cmake-3.15.2-Linux-x86_64.tar.gz && \
    mv /cmake-3.15.2-Linux-x86_64 /cmake && \
    rm -f cmake-3.15.2-Linux-x86_64.tar.gz && \
    wget https://github.com/CMU-Perceptual-Computing-Lab/openpose/archive/v"$OP_VER".tar.gz && \
    tar xf v"$OP_VER".tar.gz && \
    mv /openpose-"$OP_VER" /openpose && \
    rm -f v"$OP_VER".tar.gz

# 第三方包
RUN rm -rf /openpose/3rdparty/caffe && \
    git clone https://github.com/CMU-Perceptual-Computing-Lab/caffe.git /openpose/3rdparty/caffe && \
    git clone https://github.com/pybind/pybind11.git /openpose/3rdparty/pybind11 && \
    mkdir /openpose/build

COPY Makefile.config Makefile /openpose/3rdparty/caffe/

WORKDIR /openpose/3rdparty/caffe/
RUN make -j8 && \
    make distribute DISTRIBUTE_DIR=/openpose/build/caffe/

WORKDIR /openpose/build

COPY Cuda.cmake /openpose/cmake/Cuda.cmake

RUN /cmake/bin/cmake -D CMAKE_BUILD_TYPE=RELEASE -D CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda -D CMAKE_INSTALL_PREFIX=/opt/openpose -DBUILD_PYTHON=on -DDOWNLOAD_FACE_MODEL=OFF -D DOWNLOAD_HAND_MODEL=OFF -DBUILD_CAFFE=OFF -DCaffe_INCLUDE_DIRS=/openpose/build/caffe/include/ -DCaffe_LIBS=/openpose/build/caffe/lib/libcaffe.so .. && \
    make -j8 && \
    make install

# Rebase image to a more slim image
FROM nvidia/cuda:10.2-cudnn7-runtime

# Copy compiled openpose
COPY --from=build /opt/openpose /opt/openpose
COPY --from=build /openpose/models /opt/openpose/models
COPY --from=build /openpose/build/examples /opt/openpose/examples
COPY --from=build /openpose/examples/media /opt/openpose/examples/media
COPY --from=build /openpose/build/caffe /opt/openpose/caffe

# Install the runtime libraries. We don't need the dev packages.
# ModuleNotFoundError: No module named 'skbuild'
#     pip3 install scikit-build cmake
# scikit-build could not get a working generator for your system. Aborting build.
# Building Linux wheels for Python 3.6 requires a compiler (e.g gcc).
# But scikit-build does *NOT* know how to install it on ubuntu
#     pip3 install --upgrade pip
# ImportError: libGL.so.1: cannot open shared object file
#     apt install libgl1-mesa-glx
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    libgflags2.2 liblmdb0 libgoogle-glog0v5 libatlas3-base libhdf5-100 libsnappy1v5 libleveldb1v5 libprotobuf10 libsm6 libgl1-mesa-glx \
    python3 python3-numpy python3-pip python3-setuptools \
    libopencv-core3.2 libopencv-video3.2 libopencv-calib3d3.2 libopencv-objdetect3.2 \
    libopencv-highgui3.2 libopencv-videoio3.2 libopencv-imgcodecs3.2 libopencv-imgproc3.2 \
    libboost-system1.65.1 libboost-thread1.65.1 libboost-filesystem1.65.1 \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    pip3 install --upgrade pip && \
    pip3 install opencv-python Pillow && \
    python3 -c "import cv2" && \
    echo "QT_X11_NO_MITSHM=1" >> /etc/environment && \
    echo "/opt/openpose/lib" >  /etc/ld.so.conf.d/openpose.conf && \
    echo "/opt/openpose/caffe/lib" >  /etc/ld.so.conf.d/caffe.conf && \
    ldconfig

WORKDIR /opt/openpose
