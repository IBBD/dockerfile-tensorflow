echo $(id -u):$(id -g)
sudo docker rm -f ibbd-notebook
sudo docker run -u $(id -u):$(id -g) -d --restart always \
    --name ibbd-notebook \
    --runtime=nvidia \
    -p 8888:8888 \
    -e JUPYTER_ENABLE_LAB=yes \
    -v `pwd`/work:/tf \
    -v `pwd`/config:/.jupyter \
    registry.cn-hangzhou.aliyuncs.com/ibbd/notebook:gpu \
    jupyter lab --ip 0.0.0.0 \
        --config /.jupyter/jupyter_notebook_config.py \
        --notebook-dir /tf 


