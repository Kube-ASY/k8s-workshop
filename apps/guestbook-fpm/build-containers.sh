#!/bin/bash

export HARBOR=harbor2.csvcdev.vpc.arvato-systems.de/k8s-workshop

# Build Guestbook

docker build -t ${HARBOR}/gb-phpfpm:v8 docker/

docker push  ${HARBOR}/gb-phpfpm:v8

docker build -t ${HARBOR}/gb-phpfpm:v7 docker-sts/

docker push  ${HARBOR}/gb-phpfpm:v7


# Copy nginx container to Harbor

#docker pull bitnami/nginx:1.19
docker build -t ${HARBOR}/gb-nginx:latest -t ${HARBOR}/gb-nginx:1.19.1 -f docker/Dockerfile.nginx docker/

docker push ${HARBOR}/gb-nginx:1.19.1
docker push ${HARBOR}/gb-nginx:latest

# Copy redis Container to Harbor

docker pull redis:6.0

docker tag redis:6.0 ${HARBOR}/redis:6.0

docker push ${HARBOR}/redis:6.0


