#!/bin/bash

export MINIKUBE=v1.23.2
export K8S=v1.20.10

sudo apt-get update
sudo apt-get upgrade -y 

sudo snap refresh

minikube stop

wget https://github.com/kubernetes/minikube/releases/download/${MINIKUBE}/minikube-linux-amd64 -O /tmp/minikube

sudo install /tmp/minikube /usr/local/bin/

minikube delete

docker system prune -a

minikube start --kubernetes-version=$K8S

minikube addons enable metrics-server
minikube addons enable dashboard
minikube addons enable storage-provisioner
minikube addons enable default-storageclass
minikube addons enable ingress



