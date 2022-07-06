#!/bin/bash
TAG="gfkri/cuda:ubuntu-18.04_cuda-10.1_cudnn-7"
docker build -t $TAG .
DANGLING_IMAGES=$(docker images -f "dangling=true" -q)
if [ ! -z "$DANGLING_IMAGES" ]
then
    docker rmi $DANGLING_IMAGES
fi