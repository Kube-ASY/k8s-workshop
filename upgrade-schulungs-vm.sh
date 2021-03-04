#!/bin/bash

export MINIKUBE=v1.18.0
export K8S=v1.20.2

sudo apt-get update
sudo apt-get upgrade -y 

sudo snap refresh

minikube stop

wget https://github.com/kubernetes/minikube/releases/download/${MINIKUBE}/minikube-linux-amd64 -O /tmp/minikube

sudo install /tmp/minikube /usr/local/bin/

minikube start --kubernetes-version=$K8S



