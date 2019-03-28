# Ubuntu 16.04

## cuda101-cudnn7-py36-ubuntu1804

- cu101-py36-u1804-cv-dlib: 增加opencv, dlib, numpy, pandas, scipy, scikit-learn
- gpu: ocr, flask, moviepy...

## 10.0-cudnn7-devel  (requires nvidia-docker v2)

#### REPOSITORY: 
`registry.cn-hangzhou.aliyuncs.com/ibbd/video`

#### tags: 
* `gpu`(gpu.Dockerfile)
* `cuda_base` (cuda_base.Dockerfile)
* `py3_cuda_base` (py3_cuda_base.Dockerfile)
* `py3_cuda_opencv` (py3_cuda_opencv.Dockerfile)
* `py3_cuda_opencv_dlib` (py3_cuda_opencv_dlib.Dockerfile)

#### 版本说明：

* python 3.5.2
* opencv & opencv_contrib 3.4.2
* dlib 19.16.99

可根据需要修改重新制作镜像。

   

## 1 gpu

1.1 使用`mettainnovations/ubuntu-base:16.04-cuda10`作为基础镜像。

1.2 该镜像编译了opencv（CPU）、dlib（CUDA）、ocr包等。

1.4 在阿里云 `docker build` 。



## 2 cuda_base

1.1 使用`nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04`作为基础镜像。

1.2 同样可以选择其他 https://gitlab.com/nvidia/cuda/ 镜像作为基础镜像。

1.3 该镜像可直接用于opencv cuda编译，但是要编译dlib的话，安装其他包（cuda_base.Dockerfile）。

1.4 在阿里云 `docker build` 。



## 3 py3_cuda_base 

2.1 安装python3 ,一些基础包（按需增减），下载 opencv安装包。

2.2 在阿里云 `docker build` 。



## 4 py3_cuda_opencv

3.1 编译opencv cuda 版本。

3.2 在本地制作：

```shell
docker build -t registry.cn-hangzhou.aliyuncs.com/ibbd/video:py3_cuda_opencv -f ./py3_cuda_opencv.Dockerfile .
```



## 5 py3_cuda_opencv_dlib 

4.1 编译 dlib cuda 版本。

4.2 由于编译dlib会自动安装cmake，导致cmake出问题，需要最后编译dlib。

4.3 在本地制作镜像：

```shell
docker build -t registry.cn-hangzhou.aliyuncs.com/ibbd/video:py3_cuda_opencv_dlib -f ./py3_cuda_opencv_dlib.Dockerfile .
```



## 6 pip3 list（py3_cuda_opencv_dlib）
```
Package           Version               
----------------- ----------------------
aniso8601         4.1.0                 
certifi           2018.11.29            
chardet           3.0.4                 
Click             7.0                   
cmake             3.13.3                
decorator         4.3.0                 
dlib              19.16.99              
face-lib          0.1.4                 
fire              0.1.3                 
fireRest          0.3.3                 
Flask             1.0.2                 
Flask-JSONRPC     0.3.1                 
Flask-RESTful     0.3.7                 
idna              2.8                   
imageio           2.4.1                 
itsdangerous      1.1.0                 
Jinja2            2.10                  
jsonschema        2.6.0                 
MarkupSafe        1.1.0                 
moviepy           0.2.3.5               
numpy             1.16.0                
pandas            0.23.4                
Pillow            5.4.1                 
pip               18.1                  
pycrypto          2.6.1                 
pycurl            7.43.0                
pygobject         3.20.0                
pytesseract       0.2.6                 
python-apt        1.1.0b1+ubuntu0.16.4.2
python-dateutil   2.7.5                 
pytz              2018.9                
requests          2.21.0                
requests-toolbelt 0.8.0                 
scikit-learn      0.20.2                
scipy             1.2.0                 
setuptools        40.6.3                
six               1.12.0                
tqdm              4.29.1                
urllib3           1.24.1                
Werkzeug          0.14.1
wheel             0.29.0
```
