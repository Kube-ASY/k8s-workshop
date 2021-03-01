#!/bin/bash

export HARBOR=harbor2.csvcdev.vpc.arvato-systems.de/k8s-workshop

# Build stress

docker build -t ${HARBOR}/stress:latest docker-stress
docker build -t ${HARBOR}/workload:1.0 -f docker-stress/Dockerfile-120 docker-stress
docker push ${HARBOR}/stress:latest
docker push ${HARBOR}/workload:1.0




