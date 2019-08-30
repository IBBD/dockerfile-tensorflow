# Pull base image.
FROM cagdasbas/openpose-gpu:1.4-10.0-cudnn7-runtime

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

ADD scripts/openpose-image.py /opt/openpose/python/openpose/

RUN RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install server
RUN git clone https://github.com/ibbd-dev/python-fire-rest /fire-rest \
    && cd /fire-rest \
    && pip3 install -r requirements.txt \
    && python3 setup.py install --user \
    && rm -rf .git \
    && rm -f *.md

WORKDIR /opt/openpose/python/openpose
