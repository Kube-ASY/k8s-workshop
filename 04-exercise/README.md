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

## (c) Environment und ConfigMaps
* Erstelle eine Secret mit Namen `hellowe` im Namespace `hello-04` die unter dem key `message` den Text "Kubernetes Workshop Hello App!" enthält.
* Füge dem Container im Deployment helloweb eine Umgebungsvariable `HELLO_MESSAGE` hinzu, die aus dem o.a. ConfigMap-Key gefüllt wird.

## Lösungen:
### (a) 

```
a3ViZWN0bCBjcmVhdGUgbnMgaGVsbG93ZWItMDQKa3ViZWN0bCAtbiBoZWxsby0wNCBhcHBseSAtZiBoZWxsb3dlYi1kZXBsb3ltZW50LnlhbWwKa3ViZWN0bCAtbiBoZWxsby0wNCBhcHBseSAtZiBoZWxsb3dlYi1zZXJ2aWNlLnlhbWwKa3ViZWN0bCAtbiBoZWxsby0wNCBnZXQgYWxsCmt1YmVjdGwgLW4gaGVsbG8tMDQgcG9ydC1mb3J3YXJkIDgwODA6ODAgc3ZjL2hlbGxvd2ViCmN1cmwgaHR0cDovL2xvY2FsaG9zdDo4MDgwLw==
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
* helloweb-deployment.yaml
```yaml
YXBpVmVyc2lvbjogYXBwcy92MQpraW5kOiBEZXBsb3ltZW50Cm1ldGFkYXRhOgogIG5hbWU6IGhlbGxvd2ViCiAgbGFiZWxzOgogICAgYXBwOiBoZWxsbwpzcGVjOgogIHNlbGVjdG9yOgogICAgbWF0Y2hMYWJlbHM6CiAgICAgIGFwcDogaGVsbG8KICAgICAgdGllcjogd2ViCiAgdGVtcGxhdGU6CiAgICBtZXRhZGF0YToKICAgICAgbGFiZWxzOgogICAgICAgIGFwcDogaGVsbG8KICAgICAgICB0aWVyOiB3ZWIKICAgIHNwZWM6CiAgICAgIGNvbnRhaW5lcnM6CiAgICAgIC0gbmFtZTogaGVsbG8tYXBwCiAgICAgICAgZW52OgogICAgICAgICAgLSBuYW1lOiBIRUxMT19NRVNTQUdFCiAgICAgICAgICAgIHZhbHVlRnJvbToKICAgICAgICAgICAgICBzZWNyZXRLZXlSZWY6CiAgICAgICAgICAgICAgICBuYW1lOiBoZWxsb3dlYgogICAgICAgICAgICAgICAga2V5OiBtZXNzYWdlCiAgICAgICAgaW1hZ2U6IGhhcmJvcjIuY3N2Y2Rldi52cGMuYXJ2YXRvLXN5c3RlbXMuZGUvazhzLXdvcmtzaG9wL2hlbGxvLXBocDoxLjAKICAgICAgICBwb3J0czoKICAgICAgICAtIGNvbnRhaW5lclBvcnQ6IDgw
```