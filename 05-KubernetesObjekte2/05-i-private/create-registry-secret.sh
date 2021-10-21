#!/bin/bash

echo "Enter Registry Token: "

read RPWD

kubectl -n k8s-workshop create secret docker-registry myregistrykey \
  --docker-server=harbor.csvcdev.vpc.arvato-systems.de \
  --docker-username='robot$k8s-workshop-private+private' \
  --docker-password=$RPWD
