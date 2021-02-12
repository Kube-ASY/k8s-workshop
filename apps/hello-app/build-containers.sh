#!/bin/bash

export HARBOR=harbor2.csvcdev.vpc.arvato-systems.de/k8s-workshop

# Build Guestbook

docker build -t ${HARBOR}/hello-app:1.0 docker-1.0.0/
docker build -t ${HARBOR}/hello-app:2.0 docker-2.0.0/
docker push  ${HARBOR}/hello-app:1.0
docker push  ${HARBOR}/hello-app:2.0




