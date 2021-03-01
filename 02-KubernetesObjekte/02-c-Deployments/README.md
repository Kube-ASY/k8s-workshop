# Deployments

## YAML Code
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: helloweb
  labels:
    app: hello
spec:
  selector:
    matchLabels:
      app: hello
      tier: web
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
  template:
    metadata:
      labels:
        app: hello
        tier: web
    spec:
      containers:
      - name: hello-app
        image: harbor2.csvcdev.vpc.arvato-systems.de/k8s-workshop/hello-app:1.0
        ports:
        - containerPort: 8080
```

## Create Deployment from YAML Manifest

    kubectl apply -f helloweb-deployment.yaml

    kubectl get deployment

    kubectl get pods

    kubectl get pods -o yaml

    kubectl get replicaset

    

  

