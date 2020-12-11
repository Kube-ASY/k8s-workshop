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

## Query

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



