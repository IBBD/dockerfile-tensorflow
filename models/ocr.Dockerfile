FROM debian:stretch-slim

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

RUN apt-get update -y \
    && apt-get install -y wget

RUN mkdir /models/ 

ADD gdown.pl /gdown.pl
RUN chmod +x /gdown.pl 

RUN ./gdown.pl "https://drive.google.com/open?id=1Jk4eGD7crsqCCg9C9VjCLkMN3ze8kutZ" \
    /models/CRAFT_General.weights 

RUN ./gdown.pl "https://drive.google.com/open?id=1i2R7UIUqmkUtF0jv_3MXTqmQ_9wuAnLf" \
    /models/CRAFT_IC15.weights 

RUN ./gdown.pl "https://drive.google.com/open?id=1XSaFwBkOaFOdtk4Ane3DFyJGPRw6v5bO" \
    /models/CRAFT_LinkRefiner.weights 
