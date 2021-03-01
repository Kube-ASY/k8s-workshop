# Übungen 1

## (a) Deployment der hello-app

Deploye die hello-app in diesem Verzeichnis in dem Du 
* Einen Namespace erstellen mit Namen `hello-04`
* Deploye das Deployment aus den beiden .yaml Dateien aus diesem Verzeichnis in diesen Namespace:
    * `helloweb-deployment.yaml`
    * `helloweb-service.yaml`
* Erkunde die erstelten Kubernetes Objekte
* Erstelle ein Port Forwarding um auf den Service zugreifen zu können
* Besuche den Service mit einen Browser oder `curl`

## (b) LoadBalancer Service
* Ändere den Service so dass eine Service vom Typ `LoadBalanacer` erstellt wird
* Deploye die Änderung im Cluster
* Aktiviere im Minikube die LoadBalancer Emulation (in einem anderen Terminal `minikube tunnel` ausführen)
* Ermittle die externe IP des Loadbalancers
* Greife direkt mit dem Browser auf die externe IP des Service zu.

## (c) Environment und Secrets
* Erstelle eine Secret mit Namen `hellowe` im Namespace `hello-04` die unter dem key `message` den Text "Kubernetes Workshop Hello App!" enthält.
* Füge dem Container im Deployment helloweb eine Umgebungsvariable `HELLO_MESSAGE` hinzu, die aus dem o.a. ConfigMap-Key gefüllt wird.
* Ändere den Text im Secret. Überprüfe wie die App darauf regiert.
* Was ist zu tun damit der neue Text angezeigt wird.

## (d) Scaling / Deployment
* Scaliere das Deployment auf 5 Pods
* Ändere den Container im Deployment auf das Tag `2.0` im yaml File
* Deploye die Änderung
* Beobachte das Deployment

## Lösungen:
### (a) 

```
a3ViZWN0bCBjcmVhdGUgbnMgaGVsbG8tMDQKa3ViZWN0bCAtbiBoZWxsby0wNCBhcHBseSAtZiBoZWxsb3dlYi1kZXBsb3ltZW50LnlhbWwKa3ViZWN0bCAtbiBoZWxsby0wNCBhcHBseSAtZiBoZWxsb3dlYi1zZXJ2aWNlLnlhbWwKa3ViZWN0bCAtbiBoZWxsby0wNCBnZXQgYWxsCmt1YmVjdGwgLW4gaGVsbG8tMDQgcG9ydC1mb3J3YXJkIHN2Yy9oZWxsb3dlYiA4MDgwOjgwICYKY3VybCBodHRwOi8vbG9jYWxob3N0OjgwODAvCmtpbGwgJTEK
```
### (b)
* `helloweb-service.yaml`
```yaml
YXBpVmVyc2lvbjogdjEKa2luZDogU2VydmljZQptZXRhZGF0YToKICBuYW1lOiBoZWxsb3dlYgogIGxhYmVsczoKICAgIGFwcDogaGVsbG8Kc3BlYzoKICBzZWxlY3RvcjoKICAgIGFwcDogaGVsbG8KICAgIHRpZXI6IHdlYgogIHBvcnRzOgogIC0gcG9ydDogODAKICAgIHRhcmdldFBvcnQ6IDgwCiAgdHlwZTogTG9hZEJhbGFuY2Vy
```

```bash
a3ViZWN0bCAtbiBoZWxsby0wNCBhcHBseSAtZiBoZWxsb3dlYi1zZXJ2aWNlLnlhbWwKa3ViZWN0bCAtbiBoZWxsby0wNCBnZXQgc2VydmljZSBoZWxsb3dlYgo9PiBtaW5pa3ViZSB0dW5uZWw=

```

### (c)
* create secret
```
a3ViZWN0bCAtbiBoZWxsby0wNCBjcmVhdGUgc2VjcmV0IGdlbmVyaWMgaGVsbG93ZWIgLS1mcm9tLWxpdGVyYWw9bWVzc2FnZT0nS3ViZXJuZXRlcyBXb3Jrc2hvcCBIZWxsbyBBcHAhJw==
```
* `helloweb-secret.yaml` 
```yaml
YXBpVmVyc2lvbjogdjEKa2luZDogU2VjcmV0Cm1ldGFkYXRhOgogIG5hbWU6IGhlbGxvd2ViCnN0cmluZ0RhdGE6CiAgbWVzc2FnZTogIkt1YmVybmV0ZXMgV29ya3Nob3AgSGVsbG8gQXBwISIKLS0tCmFwaVZlcnNpb246IHYxCmtpbmQ6IFNlY3JldAptZXRhZGF0YToKICBuYW1lOiBoZWxsb3dlYgp0eXBlOiBPcGFxdWUKZGF0YToKICBtZXNzYWdlOiBTM1ZpWlhKdVpYUmxjeUJYYjNKcmMyaHZjQ0JJWld4c2J5QkJjSEFo
```
```
kubectl -n hello-04 apply -f helloweb-secret-yaml
```
* helloweb-deployment.yaml
```yaml
YXBpVmVyc2lvbjogYXBwcy92MQpraW5kOiBEZXBsb3ltZW50Cm1ldGFkYXRhOgogIG5hbWU6IGhlbGxvd2ViCiAgbGFiZWxzOgogICAgYXBwOiBoZWxsbwpzcGVjOgogIHNlbGVjdG9yOgogICAgbWF0Y2hMYWJlbHM6CiAgICAgIGFwcDogaGVsbG8KICAgICAgdGllcjogd2ViCiAgdGVtcGxhdGU6CiAgICBtZXRhZGF0YToKICAgICAgbGFiZWxzOgogICAgICAgIGFwcDogaGVsbG8KICAgICAgICB0aWVyOiB3ZWIKICAgIHNwZWM6CiAgICAgIGNvbnRhaW5lcnM6CiAgICAgIC0gbmFtZTogaGVsbG8tYXBwCiAgICAgICAgZW52OgogICAgICAgICAgLSBuYW1lOiBIRUxMT19NRVNTQUdFCiAgICAgICAgICAgIHZhbHVlRnJvbToKICAgICAgICAgICAgICBzZWNyZXRLZXlSZWY6CiAgICAgICAgICAgICAgICBuYW1lOiBoZWxsb3dlYgogICAgICAgICAgICAgICAga2V5OiBtZXNzYWdlCiAgICAgICAgaW1hZ2U6IGhhcmJvcjIuY3N2Y2Rldi52cGMuYXJ2YXRvLXN5c3RlbXMuZGUvazhzLXdvcmtzaG9wL2hlbGxvLXBocDoxLjAKICAgICAgICBwb3J0czoKICAgICAgICAtIGNvbnRhaW5lclBvcnQ6IDgw
```
* `helloweb-secret.yaml` 
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: helloweb
stringData:
  message: "<h1>Kubernetes Workshop Hello App!</h1><h2>Have a nice day</h2>"
```
```sh
kubectl -n hello-04 apply -f helloweb-secret-yaml
```
* Delete Pod / Restart Deployment Rollout
```sh
kubectl -n hello-04 get pods
kubectl -n hello-04 delete pod  <pod>
# or
kubectl -n hello-04 delete pod -l app=hello -l tier=web
# or
kubectl -n hello-04 rollout restart deployment helloweb
```
### (d) Scale
* `kubectl -n hello-04 scale deployment helloweb --replicas=5`
* `kubectl -n hello-04 set image deployment helloweb hello-app=harbor2.csvcdev.vpc.arvato-systems.de/k8s-workshop/hello-php:2.0`
* `watch kubectl -n hello-04 get pods`

### (e) 
