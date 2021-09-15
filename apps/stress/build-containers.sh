#!/bin/bash

export HARBOR=harbor.csvcdev.vpc.arvato-systems.de/k8s-workshop

# Build stress

docker build -t ${HARBOR}/stress:latest docker-stress
docker build -t ${HARBOR}/workload:2.0 -f docker-stress/Dockerfile-300 docker-stress
docker push ${HARBOR}/stress:latest
docker push ${HARBOR}/workload:2.0




