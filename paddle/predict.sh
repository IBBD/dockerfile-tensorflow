#!/bin/bash
# 
# 
# Author: alex
# Created Time: 2019年09月20日 星期五 10时14分43秒
python predict.py --model_name=BMN \
                  --config=./configs/bmn.yaml \
                  --log_interval=1 \
                  --weights=/data/models/BMN_final.pdparams \
                  --filelist=/data/20190829_144532.mp4 \
                  --use_gpu=True

