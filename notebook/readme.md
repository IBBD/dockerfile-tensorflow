# Notebook Dockerfile

## 支持特性

- [x] 支持Jupyterlab
- [x] 支持Anaconda Notebook的基础包，从Anaconda迁移过来应该能无缝迁移。
- [x] 支持GPU
- [x] 支持Tensorflow, TensorBoard和Keras
- [x] 支持Pytorch
- [x] 支持图像处理，如Opencv
- [x] 支持常用的机器学习库，如XGBoost, LightGBM, Catboost等
- [x] 支持常见的NLP工具，如jieba, gensim, fasttext, pytext, flair等
- [ ] 支持LaTeX导出PDF
- [ ] 支持数学公式
- [x] 解决matplotlib的中文显示问题
- [x] 支持可解释模型的相关包
- [x] 支持时间序列建模。

## 踩坑记录

### 无法下载文件
修改配置文件：

```sh
c.NotebookApp.disable_check_xsrf = True
```


