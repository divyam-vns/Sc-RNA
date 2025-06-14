#!/bin/bash

# Directory to mount into the container
HOST_DIR=~/scrnaseq_workshop
CONTAINER_DIR=/home/rstudio/project
IMAGE=quay.io/nbisweden/workshop-scRNAseq:2023.10
PORT=8888

# Create local directory if it doesn't exist
mkdir -p "$HOST_DIR"

# Run Docker container
docker run -it --rm \
  -p ${PORT}:8888 \
  -v ${HOST_DIR}:${CONTAINER_DIR} \
  $IMAGE
