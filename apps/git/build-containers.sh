#!/bin/bash

export HARBOR=harbor.csvcdev.vpc.arvato-systems.de/k8s-workshop

# Copy git Container to Harbor

docker pull bitnami/git:latest

docker tag bitnami/git:latest ${HARBOR}/git:latest

docker push ${HARBOR}/git:latest



