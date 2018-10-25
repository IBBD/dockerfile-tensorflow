# dockerfile-tensorflow
cpu版本基于`python:3.6-stretch`构建，gpu版本基于`tensorflow/tensorflow:latest-gpu-py3`构建。

tag说明：

- latest: 默认的cpu版本
- intel-cpu: tf使用Intel编译的cpu版本
- local-cpu: tf使用本地编译的cpu版本
- gpu: 默认gpu版本

## pip install

- numpy
- pandas
- scipy
- sklearn
- matplotlib
- tensorflow
- keras

辅助包：

- flask
- flask_jsonrpc
- fire


