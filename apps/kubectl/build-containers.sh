#!/bin/bash

export HARBOR=harbor2.csvcdev.vpc.arvato-systems.de/k8s-workshop

# Build Guestbook

docker build -t ${HARBOR}/kubectl:latest -t ${HARBOR}/kubectl:1.20.0 docker-kubectl
docker push  ${HARBOR}/kubectl:1.20.0
docker push  ${HARBOR}/kubectl:latest




