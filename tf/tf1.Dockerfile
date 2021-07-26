FROM registry.cn-hangzhou.aliyuncs.com/ibbd/cuda:cuda102-cudnn7-py38-ubuntu2004-dev

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
