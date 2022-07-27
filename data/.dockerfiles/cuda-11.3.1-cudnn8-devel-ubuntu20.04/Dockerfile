FROM nvidia/cuda:11.3.1-cudnn8-devel-ubuntu20.04
LABEL maintainer="Georg Krispel <georg.krispel@icg.tugraz.at>"

ARG DEBIAN_FRONTEND=noninteractive
ARG APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1

RUN apt-get update && \
    apt-get install software-properties-common -y && \
    add-apt-repository ppa:deadsnakes/ppa -y && \
    apt-get install -y ca-certificates wget && \
    wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | apt-key add - && \
    apt-add-repository 'deb https://apt.kitware.com/ubuntu/ bionic main' -y && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    gcc \
    git \
    g++ \
    imagemagick \
    libatlas-base-dev \
    libboost-all-dev \
    libblas-dev \
    libeigen3-dev \
    liblapack-dev \
    protobuf-compiler \
    libprotobuf-dev \
    ffmpeg \
    libxvidcore4 \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-alsa \
    gstreamer1.0-libav \
    x264 \
    libx264-dev \
    virtualenv \
    build-essential \   
    python-setuptools \
    python3-dev \
    python3-pip \
    python3-venv \
    python3-wheel \
    python3.8-dev \
    python3.8-venv \
    python3.9-dev \
    python3.9-venv \
    python3-setuptools \
    libopencv-dev \
    libopencv-contrib-dev \
    mlocate \
    unzip \
    wget \
    python3-tk \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* 


#ENV CUDA_CACHE_MAXSIZE=2147483648 \
#    CUDA_CACHE_DISABLE=0 \
#    CUDA_CACHE_PATH=/root/.nv/ComputeCache

# RUN echo $HOME




      
