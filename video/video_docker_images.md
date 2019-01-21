## 1 原始镜像

* Dockerfile 文件
	`py3_cuda_base.Dockerfile`
* install
```sh
FROM mettainnovations/ubuntu-base:16.04-cuda10
```
​	添加 基础包，配置环境    
* images
	`registry.cn-hangzhou.aliyuncs.com/ibbd/video:py3_cuda_base`



## 2 安装 opencv

* Dockerfile 文件
	`py3_cuda_opencv.Dockerfile`
* images
	`registry.cn-hangzhou.aliyuncs.com/ibbd/video:py3_cuda_opencv`



## 3 安装 dlib

* Dockerfile 文件
	`py3_cuda_opencv_dlib.Dockerfile`
* images
	`registry.cn-hangzhou.aliyuncs.com/ibbd/video:py3_cuda_opencv_dlib`