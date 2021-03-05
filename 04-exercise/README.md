# Übungen 1

## (a) _Deployment_ der hello-app

Deploye die hello-app in diesem Verzeichnis in dem Du 
* Einen _Namespace_ erstellen mit Namen `hello-04`
* Deploye das _Deployment_ aus den beiden .yaml Dateien aus diesem Verzeichnis in diesen _Namespace_:
    * `helloweb-_Deployment_.yaml`
    * `helloweb-service.yaml`
    * In den Objekten ist der neue _Namespace_ nicht konfiguriert. Um sie im _Namespace_ zu deployen muss Du entweder den _Namespace_ angeben `kubectl -n <namespace>` oder den Context für alle kubectl Befehle auf einen _Namespace_ setzen: `kubectl config set-context --current --namespace=<namespace>`
    
* Erkunde die erstelten Kubernetes Objekte
* Erstelle ein _Port Forward_ um auf den im Pod laufenden Webservice zugreifen zu können. Versuche es direkt zum _Pod_ und über den _Service_.
* Besuche den Webservice mit einen Browser oder `curl`

## (b) LoadBalancer Service
* Ändere das _Service_ Manifest, so dass eine _Service_ vom Typ `LoadBalancer` erstellt wird
* Deploye die Änderung im Cluster
* Aktiviere im Minikube die LoadBalancer Emulation (in einem anderen Terminal `minikube tunnel` ausführen)
* Ermittle die externe IP des Loadbalancers
* Greife direkt mit dem Browser auf die externe IP des Service zu.

## (c) Environment und _Secret_s
* Erstelle eine _Secret_ mit Namen `helloweb` im _Namespace_ `hello-04` die unter dem key `message` den Text "Kubernetes Workshop Hello App!" enthält.
* Füge dem Container im _Deployment_ helloweb eine Umgebungsvariable `HELLO_MESSAGE` hinzu, die aus dem o.a. _Secret_-Key gefüllt wird.
Hinweis: die Syntax für eine Secret-Referenz findest Du hier: [https://kubernetes.io/docs/concepts/configuration/secret/#using-secrets-as-environment-variables]
* Ändere den Text im _Secret_. Überprüfe wie die App darauf reagiert.
  (Es ist OK das Secret zu löschen und neu anzulegen, aber was müsste man tun um es zu ändern?)
* Was ist zu tun damit der neue Text angezeigt wird.

## (d) Scaling / _Deployment_
* Scaliere das _Deployment_ auf 5 Pods
* Ändere den Container im _Deployment_ auf das Tag `2.0` im yaml File
* Deploye die Änderung
* Beobachte das _Deployment_

## Cleanup
* Lösche am Ende der Übung den _Namespace_ und 

## Lösungen:
Die Lösungen sind Baset64 kodiert um sie zu lesen
  * Kodierten Text kopieren und z.B. hier Online Decodieren: [https://www.base64decode.org/]
  * Kodierten Text in das Tool base64 pipen
    `echo "<CODIERT>" | base64 -d
  * Im VisualStudioCode Editor die Extension `vscode-base64` installieren. Dann kann man Base64 Text markieren und mit Ctrl-e Ctrl-d dekodieren (Ctrl-e Ctrl-e kodiert)
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
* create _Secret_
```
a3ViZWN0bCAtbiBoZWxsby0wNCBjcmVhdGUgc2VjcmV0IGdlbmVyaWMgaGVsbG93ZWIgLS1mcm9tLWxpdGVyYWw9bWVzc2FnZT0nS3ViZXJuZXRlcyBXb3Jrc2hvcCBIZWxsbyBBcHAhJw==
```
* Oder als YAML Manifest `helloweb-secret.yaml` 
```yaml
YXBpVmVyc2lvbjogdjEKa2luZDogU2VjcmV0Cm1ldGFkYXRhOgogIG5hbWU6IGhlbGxvd2ViCnN0cmluZ0RhdGE6CiAgbWVzc2FnZTogIkt1YmVybmV0ZXMgV29ya3Nob3AgSGVsbG8gQXBwISIKLS0tCmFwaVZlcnNpb246IHYxCmtpbmQ6IFNlY3JldAptZXRhZGF0YToKICBuYW1lOiBoZWxsb3dlYgp0eXBlOiBPcGFxdWUKZGF0YToKICBtZXNzYWdlOiBTM1ZpWlhKdVpYUmxjeUJYYjNKcmMyaHZjQ0JJWld4c2J5QkJjSEFo
```
```
a3ViZWN0bCAtbiBoZWxsby0wNCBhcHBseSAtZiBoZWxsb3dlYi1zZWNyZXQteWFtbA==
```
* helloweb-deployment.yaml
```yaml
YXBpVmVyc2lvbjogYXBwcy92MQpraW5kOiBEZXBsb3ltZW50Cm1ldGFkYXRhOgogIG5hbWU6IGhlbGxvd2ViCiAgbGFiZWxzOgogICAgYXBwOiBoZWxsbwpzcGVjOgogIHNlbGVjdG9yOgogICAgbWF0Y2hMYWJlbHM6CiAgICAgIGFwcDogaGVsbG8KICAgICAgdGllcjogd2ViCiAgdGVtcGxhdGU6CiAgICBtZXRhZGF0YToKICAgICAgbGFiZWxzOgogICAgICAgIGFwcDogaGVsbG8KICAgICAgICB0aWVyOiB3ZWIKICAgIHNwZWM6CiAgICAgIGNvbnRhaW5lcnM6CiAgICAgIC0gbmFtZTogaGVsbG8tYXBwCiAgICAgICAgZW52OgogICAgICAgICAgLSBuYW1lOiBIRUxMT19NRVNTQUdFCiAgICAgICAgICAgIHZhbHVlRnJvbToKICAgICAgICAgICAgICBzZWNyZXRLZXlSZWY6CiAgICAgICAgICAgICAgICBuYW1lOiBoZWxsb3dlYgogICAgICAgICAgICAgICAga2V5OiBtZXNzYWdlCiAgICAgICAgaW1hZ2U6IGhhcmJvcjIuY3N2Y2Rldi52cGMuYXJ2YXRvLXN5c3RlbXMuZGUvazhzLXdvcmtzaG9wL2hlbGxvLXBocDoxLjAKICAgICAgICBwb3J0czoKICAgICAgICAtIGNvbnRhaW5lclBvcnQ6IDgw
```
* Neues `helloweb-secret.yaml` 
```yaml
YXBpVmVyc2lvbjogdjEKa2luZDogX1NlY3JldF8KbWV0YWRhdGE6CiAgbmFtZTogaGVsbG93ZWIKc3RyaW5nRGF0YToKICBtZXNzYWdlOiAiPGgxPkt1YmVybmV0ZXMgV29ya3Nob3AgSGVsbG8gQXBwITwvaDE+PGgyPkhhdmUgYSBuaWNlIGRheTwvaDI+Ig==
```
* Apply changed Secret
```sh
a3ViZWN0bCAtbiBoZWxsby0wNCBhcHBseSAtZiBoZWxsb3dlYi1zZWNyZXQueWFtbA==
```
* Delete Pod / Restart _Deployment_ Rollout
```sh
a3ViZWN0bCAtbiBoZWxsby0wNCBnZXQgcG9kcwprdWJlY3RsIC1uIGhlbGxvLTA0IGRlbGV0ZSBwb2QgIDxwb2Q+CiMgb3IKa3ViZWN0bCAtbiBoZWxsby0wNCBkZWxldGUgcG9kIC1sIGFwcD1oZWxsbyAtbCB0aWVyPXdlYgojIG9yCmt1YmVjdGwgLW4gaGVsbG8tMDQgcm9sbG91dCByZXN0YXJ0IGRlcGxveW1lbnQgaGVsbG93ZWI=
```
### (d) Scale
* `a3ViZWN0bCAtbiBoZWxsby0wNCBzY2FsZSBkZXBsb3ltZW50IGhlbGxvd2ViIC0tcmVwbGljYXM9NQ==`
* `a3ViZWN0bCAtbiBoZWxsby0wNCBzZXQgaW1hZ2UgZGVwbG95bWVudCBoZWxsb3dlYiBoZWxsby1hcHA9aGFyYm9yMi5jc3ZjZGV2LnZwYy5hcnZhdG8tc3lzdGVtcy5kZS9rOHMtd29ya3Nob3AvaGVsbG8tcGhwOjIuMA==`
* `d2F0Y2gga3ViZWN0bCAtbiBoZWxsby0wNCBnZXQgcG9kcw==`


