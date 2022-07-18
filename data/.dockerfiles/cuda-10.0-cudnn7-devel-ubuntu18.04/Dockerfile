FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04
LABEL maintainer="Georg Krispel <georg.krispel@icg.tugraz.at>"

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
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
    liblas-dev \
    liblas-c-dev \
    protobuf-compiler \
    libprotobuf-dev \
    ffmpeg \
    libxvidcore4 \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-alsa \
    gstreamer1.0-fluendo-mp3 \
    gstreamer1.0-libav \
    x264 \
    libx264-dev \
    virtualenv \
    build-essential \   
    python-dev \
    python-pip \
    python-wheel \
    python-setuptools \
    python3-dev \
    python3-pip \
    python3-venv \
    python3-wheel \
    python3-setuptools \
    libopencv-dev \
    libopencv-contrib-dev \
    mlocate \
    unzip \
    wget \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* 

      
RUN python3 -m venv /opt/venv_fuseseg && \
    /opt/venv_fuseseg/bin/python3 -m pip install --upgrade pip && \
    /opt/venv_fuseseg/bin/pip3 install \
      absl-py==0.6.1 \
      contextlib2==0.5.5 \
      cycler==0.10.0 \
      Cython==0.29.4 \
      easydict==1.9 \
      fastnumbers==2.1.1 \
      filelock==3.0.10 \
      gast==0.2.0 \
      grpcio==1.17.1 \
      h5py==2.9.0 \
      ImageHash==4.0 \
      intervaltree==3.0.2 \
      joblib==0.10.3 \
      Keras-Applications==1.0.6 \
      Keras-Preprocessing==1.0.5 \
      kiwisolver==1.0.1 \
      laspy==1.5.1 \
      Markdown==3.0.1 \
      matplotlib==3.0.2 \
      mock==2.0.0 \
      nose==1.3.7 \
      numpy==1.16.2 \
      olefile==0.46 \
      pbr==5.1.3 \
      Pillow==4.0.0 \
      pkg-resources==0.0.0 \
      progressbar==2.5 \
      protobuf==3.6.1 \
      pyparsing==2.3.0 \
      python-dateutil==2.7.5 \
      # python-pcl==0.3 \
      PyWavelets==1.0.2 \
      recordclass \
      scikit-learn==0.20.2 \
      scipy==1.2.0 \
      six==1.12.0 \
      sortedcontainers==2.1.0 \
      tensorboard==1.13.1 \
      tensorflow-estimator==1.13.0 \
      tensorflow-gpu==1.13.1 \
      termcolor==1.1.0 \
      tqdm==4.31.1 \
      vtk==8.1.2 \
      Werkzeug==0.14.1 \
      opencv-python \
      opencv-contrib-python \
      pandas

ENV LD_LIBRARY_PATH=/usr/local/cuda-10.0/extras/CUPTI/lib64:$LD_LIBRARY_PATH


      
