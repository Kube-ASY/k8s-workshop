# Service

    kubectl apply -f helloweb-service.yaml

    kubectl get service

    kubectl get endpoints

    kubectl apply -f helloweb2-deployment.yaml

    kubectl get endpoints

    # minikube tunnel 

    kubectl get services 

    # Checke Service Zugriff 

    # a) ClusterIP nicht von außerhalb des Clusters
    # b) NodePort
    kubectl get node -o wide
    curl http://<nodeip>:<nodeport>

    # c) LoadBalancer
    curl http://<external service ip>/

    

## YAML Code

```yaml
apiVersion: v1
kind: Service
metadata:
  name: helloweb
  labels:
    app: hello
spec:
  selector:
    app: hello
    tier: web
  ports:
  - port: 80
    targetPort: 8080
  type: ClusterIP
---
apiVersion: v1
kind: Service
metadata:
  name: helloweb-node
  labels:
    app: hello
spec:
  selector:
    app: hello
    tier: web
  ports:
  - port: 80
    targetPort: 8080
  type: NodePort
---
apiVersion: v1
kind: Service
metadata:
  name: helloweb-lb
  labels:
    app: hello
spec:
  selector:
    app: hello
    tier: web
  ports:
  - port: 80
    targetPort: 8080
  type: LoadBalancer


```

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