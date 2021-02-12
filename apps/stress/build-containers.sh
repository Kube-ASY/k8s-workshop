#!/bin/bash

export HARBOR=harbor2.csvcdev.vpc.arvato-systems.de/k8s-workshop

# Build stress

docker build -t ${HARBOR}/stress:latest docker-stress
docker push  ${HARBOR}/stress:latest




