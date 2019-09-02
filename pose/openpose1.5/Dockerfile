from nvidia/cuda:10.1-cudnn7-devel as build

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
RUN wget https://github.com/Kitware/CMake/releases/download/v3.15.2/cmake-3.15.2-Linux-x86_64.tar.gz && \
	tar xf cmake-3.15.2-Linux-x86_64.tar.gz && \
	mv /cmake-3.15.2-Linux-x86_64 /cmake && \
	rm -f cmake-3.15.2-Linux-x86_64.tar.gz && \
	wget https://github.com/CMU-Perceptual-Computing-Lab/openpose/archive/v1.5.0.tar.gz && \
	tar xf v1.5.0.tar.gz && \
	mv /openpose-1.5.0 /openpose && \
	rm -f v1.5.0.tar.gz

RUN rm -rf /openpose/3rdparty/caffe && \
	git clone https://github.com/CMU-Perceptual-Computing-Lab/caffe.git /openpose/3rdparty/caffe && \
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

RUN apt-get update && \
	apt-get install -y --no-install-recommends python3-pip python3-setuptools vim && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	PATH=/cmake/bin/:$PATH pip3 install dlib

# Rebase image to a more slim image
FROM nvidia/cuda:10.1-cudnn7-runtime

# Copy compiled openpose
COPY --from=build /opt/openpose /opt/openpose
COPY --from=build /openpose/models /opt/openpose/models
COPY --from=build /openpose/build/examples /opt/openpose/examples
COPY --from=build /openpose/examples/media /opt/openpose/examples/media
COPY --from=build /openpose/build/caffe /opt/openpose/caffe

# Copy gpu capable dlib
COPY --from=build /usr/local/lib/python3.6/dist-packages/dlib-19.17.0.egg-info /usr/local/lib/python3.6/dist-packages/dlib-19.17.0.egg-info
COPY --from=build /usr/local/lib/python3.6/dist-packages/dlib.cpython-36m-x86_64-linux-gnu.so /usr/local/lib/python3.6/dist-packages/dlib.cpython-36m-x86_64-linux-gnu.so

# Install the runtime libraries. We don't need the dev packages.
RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
	libgflags2.2 liblmdb0 libgoogle-glog0v5 libatlas3-base libhdf5-100 libsnappy1v5 libleveldb1v5 libprotobuf10 libsm6 \
	python3 python3-numpy python3-pip python3-setuptools \
	libopencv-core3.2 libopencv-video3.2 libopencv-calib3d3.2 libopencv-objdetect3.2 \
	libopencv-highgui3.2 libopencv-videoio3.2 libopencv-imgcodecs3.2 libopencv-imgproc3.2 \
	libboost-system1.65.1 libboost-thread1.65.1 libboost-filesystem1.65.1 \
	vim && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	pip3 install opencv-python && \
	echo "QT_X11_NO_MITSHM=1" >> /etc/environment && \
	echo "/opt/openpose/lib" >  /etc/ld.so.conf.d/openpose.conf && \
	echo "/opt/openpose/caffe/lib" >  /etc/ld.so.conf.d/caffe.conf && \
	ldconfig

WORKDIR /opt/openpose
