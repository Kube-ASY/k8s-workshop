# kubectl Basics

## Konfiguration
```
cat ~/.kube/config
```

```
kubectl version
```

## Hilfe

```
kubectl
```

```
kubectl apply --help
```


```
kubectl explain pod.spec
```

## View

### Setup Application

```
kubectl create ns k8s-workshop

kubectl config set-context --current --namespace=k8s-workshop

kubectl apply -f ../guestbook-fpm/
```
### Exploring the installation
```
kubectl get pods

kubectl -n kube-system get pods

kubectl get pods -o wide

kubectl get pods -l tier=frontend

kubectl get pod gb-nginx-548fb47888-wrmzw -o yaml

kubectl get deployments

kubectl get replicasets

kubectl get service -o wide

kubectl get service gb -o jsonpath={.spec.clusterIP}

kubectl get endpoints

kubectl get nodes -o wide

kubectl get configmap

kubectl get configmap -o yaml
```

## Write

```
kubectl apply -f ./guestbook-fpm/

kubectl create secret generic --from-literal=password=geheim

kubectl create secret generic --from-literal=password=geheim --dry-run=client -o yaml

kubectl edit deployment gb-phpfpm

kubectl diff deployment -f ../guestbook-fpm/gb-phpfpm-deployment.yaml

kubectl annotate pod -l app=guestbook arvato-systems.de/managed="true"

kubectl annotate pod -l app=guestbook --overwrite arvato-systems.de/managed="false" 

kubectl annotate pod -l app=guestbook arvato-systems.de/managed-

```

## Deploy

```
kubectl rollout status deployment gb-phpfpm

kubectl rollout restart deployment gb-phpfpm

kubectl rollout restart deployment

kubectl rollout history deployment gb-phpfpm

kubectl scale deployment gb-phpfpm --replicas=5

kubectl autoscale deployment gb-phpfpm --min=1 --max=10 --cpu-percent=10

kubectl get pods -l tier=phpfpm

minikube addon enable metrics-server

kubectl get hpa

```

## Troubleshooting

```
kubectl describe pod 

kubectl logs 

kubectl logs --tail=20 -f

kubectl logs -l tier=frontend

kubectl top pods

kubectl top nodes

kubectl exec  gb-phpfpm -- ls -l 

kubectl exec -it gb-phpfpm -- bash

kubectl port-forward gb-nginx   8080:8080

kubectl cp gb-phpfpm-:/app/index.php index.php
```

