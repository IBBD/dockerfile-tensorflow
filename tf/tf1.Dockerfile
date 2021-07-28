# FROM registry.cn-hangzhou.aliyuncs.com/ibbd/cuda:cuda102-cudnn7-py38-ubuntu2004-dev
FROM registry.cn-hangzhou.aliyuncs.com/ibbd/cuda:cuda102-cudnn7-py36-ubuntu1804

# 阿里云的源是比较快的
RUN pip3 config set global.index-url https://mirrors.aliyun.com/pypi/simple/
# RUN pip3 config set global.index-url http://mirrors.cloud.tencent.com/pypi/simple
# RUN pip3 config set global.index-url http://pypi.douban.com/simple/
# RUN pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

RUN pip3 install --no-cache-dir tensorflow-gpu==1.15

RUN pip3 install --no-cache-dir \
    fastapi \
    uvicorn \
    sqlalchemy \
    pymysql \
    loguru \
    pyyaml \
    h5py==2.10 \
    matplotlib \
    tqdm \
    pandas 

RUN pip3 install --no-cache-dir rdkit-pypi \
    && python3 -c "from rdkit import Chem; print(Chem.MolToMolBlock(Chem.MolFromSmiles('C1CCC1')))"
