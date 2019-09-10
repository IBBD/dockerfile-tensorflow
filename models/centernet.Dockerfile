FROM debian:stretch-slim

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

RUN apt-get update -y \
    && apt-get install -y wget

RUN mkdir -p /models/ \
    && cd /models 

ADD gdown.pl ./gdown.pl
RUN chmod +x gdown.pl 
# ctdet_coco_hg
RUN ./gdown.pl "https://drive.google.com/open?id=1cNyDmyorOduMRsgXoUnuyUiF6tZNFxaG" 
# ctdet_coco_dla_2x
RUN ./gdown.pl "https://drive.google.com/open?id=1pl_-ael8wERdUREEnaIfqOV_VF2bEVRT" 
# ctdet_pascal_dla_512
RUN ./gdown.pl "https://drive.google.com/open?id=1jIfK9EyqzNcupxGsp3YRnEiewrIG4_Ma" 
# ctdet_pascal_dla_384
RUN ./gdown.pl "https://drive.google.com/open?id=1IC3FZkxAQHm2rxoIGmS4YluYpZxwYkJf"
# multi_pose_hg_3x
RUN ./gdown.pl "https://drive.google.com/open?id=1n6EvwhTbz7LglVXXlL9irJia7YuakHdB"
# multi_pose_dla_3x
RUN ./gdown.pl "https://drive.google.com/open?id=1PO1Ax_GDtjiemEmDVD7oPWwqQkUu28PI" 
# ddd_3dop
RUN ./gdown.pl "https://drive.google.com/open?id=1znsM6E-aVTkATreDuUVxoU0ajL1az8rz" 
# ddd_sub
RUN ./gdown.pl "https://drive.google.com/open?id=15XuJxTxCBnA8O37M_ghjppnWmVnjC0Hp" 
