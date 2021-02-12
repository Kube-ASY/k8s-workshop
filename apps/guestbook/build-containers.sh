#!/bin/bash

export HARBOR=harbor2.csvcdev.vpc.arvato-systems.de/k8s-workshop

# Build Guestbook

docker build -t ${HARBOR}/gb-frontend:v5 docker/

docker push  ${HARBOR}/gb-frontend:v5


# Copy redis Container to Harbor

docker pull redis:6.0

docker tag redis:6.0 ${HARBOR}/redis:6.0

docker push ${HARBOR}/redis:6.0


