FROM debian:stretch-slim

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

RUN apt-get update -y \
    && apt-get install -y wget

ADD gdown.pl /gdown.pl
RUN chmod +x /gdown.pl 
RUN mkdir -p /models/ 

RUN ./gdown.pl "https://drive.google.com/open?id=1MQDyPRI0HgDHxHToudHqQ-2m8TVBciaa" \
    /models/CornerNet_Saccade_500000.pkl
RUN ./gdown.pl "https://drive.google.com/open?id=1qM8BBYCLUBcZx_UmLT0qMXNTh-Yshp4X" \
    /models/CornerNet_Squeeze_500000.pkl
