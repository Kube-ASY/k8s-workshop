# Service

    kubectl apply -f helloweb-service.yaml

    kubectl get service

    kubectl get endpoints

    kubectl apply -f helloweb2-deployment.yaml

    

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