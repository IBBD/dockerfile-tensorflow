# https://github.com/Duankaiwen/CenterNet
FROM debian:stretch-slim

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

RUN apt-get update -y \
    && apt-get install -y wget

ADD gdown.pl /gdown.pl
RUN chmod +x /gdown.pl 
RUN mkdir -p /models/ 

RUN ./gdown.pl "https://drive.google.com/open?id=1GVN-YrgExbPPcmzn_Lkr49f2IKjodg15" \
    /models/CenterNet-104
RUN ./gdown.pl "https://drive.google.com/open?id=14vJYw4P9sxDoltjp5zDkOS3QjUa2zZIP" \
    /models/CenterNet-52
