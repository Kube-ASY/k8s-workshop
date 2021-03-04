#!/bin/bash

export HARBOR=harbor2.csvcdev.vpc.arvato-systems.de/k8s-workshop


docker pull k8s.gcr.io/liveness
docker tag k8s.gcr.io/liveness ${HARBOR}/liveness:latest
docker push ${HARBOR}/liveness:latest





