echo $(id -u):$(id -g)
sudo docker rm -f ibbd-notebook-cpu
sudo docker run -u $(id -u):$(id -g) -d --restart always \
    --name ibbd-notebook-cpu \
    -p 8880:8888 \
    -e JUPYTER_ENABLE_LAB=yes \
    -v `pwd`/work:/work \
    -v `pwd`/config:/.jupyter \
    -w /work \
    registry.cn-hangzhou.aliyuncs.com/ibbd/notebook \
    jupyter lab --ip 0.0.0.0 \
        --config /.jupyter/jupyter_notebook_config.py \
        --notebook-dir /work
