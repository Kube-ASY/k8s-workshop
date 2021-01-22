#!/bin/bash

# Install Client

wget https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.13.1/kubeseal-linux-amd64 -O kubeseal
chmod +x kubeseal

# Install the Operator in the Cluster

kubectl apply -f controller.yaml