# Namespaces

```
# Create a simple Namespace
kubectl create namespace k8s-workshop

# Name the Namespace default in the context of kubeconfig
kubectl config set-context --current --namespace=k8s-workshop
```
## YAML Code

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: k8s-workshop 
```

