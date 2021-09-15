# Ingress

## Deploy helloweb Application

* Check if Ingress Controller addon is enabled
  ```bash
  minikube addons list

    |-----------------------------|----------|--------------|
    |         ADDON NAME          | PROFILE  |    STATUS    |
    |-----------------------------|----------|--------------|
    [...]
    | ingress                     | minikube | enabled ✅   |
    [...]

  ```

### Deploy sample application
```bash
kubectl apply -f helloweb-deployment.yaml -f helloweb-service.yaml
```
### Create a Ingress resource
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
name: helloweb
spec:
rules:
    - host: hello-world.info
    http:
        paths:
        - path: /
            pathType: Prefix
            backend:
              service:
                name: helloweb
                port:
                  number: 80
```
   
```bash
kubectl apply -f helloweb-ingress.yaml
kubectl get ingress
```
### Test access via Ingress

* Get IP Adress for Ingress and configure it in /etc/hosts
  ```bash
  echo "$(minikube ip) hello-world.info" | sudo tee -a /etc/hosts
  ```
* Check via CURL
  ```bash
  curl http://hello-world.info/
  ```

## Ingress with TLS

### Create a self-signed certificate

```bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout tls.key -out tls.crt -subj "/CN=hello-world.info/O=Kubernetes"
```
### Create a TLS Secret
```bash
kubectl create secret tls helloworld-tls --cert=tls.crt --key=tls.key
```

### Test with curl
```bash
curl -k  https://hello-world.info
```







