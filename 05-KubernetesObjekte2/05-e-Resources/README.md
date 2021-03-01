# Resources

## Create a Deployment to test memory limit

```bash
kubectl apply -f stress-deployment.yaml

kubectl get pods 

kubectl top pods

```

## Create a deployment with usage over limit

```bash
kubectl apply -f stress-deployment-120.yaml

watch kubectl get pods 

kubectl describe pod <>

```

## Not Enought Memory


```bash
kubectl apply -f stress-deployment-4g.yaml

kubectl get pods 

kubectl describe pod <>

```