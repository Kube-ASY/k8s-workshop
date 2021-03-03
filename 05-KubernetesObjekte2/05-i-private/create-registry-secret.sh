#!/bin/bash

echo "Enter Registry Token: "

read RPWD

kubectl create secret docker-registry myregistrykey \
  --docker-server=harbor2.csvcdev.vpc.arvato-systems.de \
  --docker-username='robot$private' \
  --docker-password=$RPWD
