# DaemonSet

## YAML

```yaml
apiVersion: apps/v1
kind: DaemonSet
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
        image: harbor.csvcdev.vpc.arvato-systems.de/k8s-workshop/hello-app:1.0
        ports:
        - containerPort: 8080
```
