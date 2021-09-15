#!/bin/bash

export HARBOR=harbor.csvcdev.vpc.arvato-systems.de/k8s-workshop

# Build Guestbook

docker build -t ${HARBOR}/hello-php:1.0 docker/
docker build -t ${HARBOR}/hello-php:2.0 docker/
docker push  ${HARBOR}/hello-php:1.0
docker push  ${HARBOR}/hello-php:2.0




