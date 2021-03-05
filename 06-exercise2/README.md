# Übungen 2

## Hosting a Website with nginx

Wir nehmen den nginx aus dem Guestbook Example und verwenden ihn um eine statische Website zu hosten.

Im Ordner befinden sich
* nginx-deployment.yaml
* nginx-configmap.yaml
* nginx-service.yaml

### (a) Basis Deplyoment + Ingress
* Erstelle einen Namespace `website` und deploye diese Komponenten darin.
* Setze den Current-Context deiner kubectl config auf diesen Namespace

* Erstelle wie in [05-g-Ingress](../05-KubernetesObjekte2/5-g-Ingress/) beschrieben einen Ingress und einen `/etc/hosts` Eintrag um auf den nginx mittels der URL `website.k8s-workshop.info` zuzugreifen. (http reicht)
    * `helloweb-ingress.yaml`
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

  * Hosts Eintrag:
  ```bash
  echo "$(minikube ip) website.k8s-workshop.info" | sudo tee -a /etc/hosts
  ```

*Wenn hier ein HTTP-404 kommt ist alles OK*

Tip: Schau in die Logs des Containers. 
Scheint wohl einfach noch kein Content vorhanden zu sein. 
Darum kümmern wir uns jetzt.


### (b) Ein Volume die Website zu hosten
* Erstelle jetzt ein PVC (PersistentVolumeClaim) mit Namen nginx-website und 1GB Größe und der StorageClass `standard`  siehe dynamic-www-pvc.yaml in [dynamic-www-pvc.yaml](../05-KubernetesObjekte2/05-d-Volumes/dynamic-www-pvc.yaml)
* Modifizieren das nginx-deployment und mounte den Inhalt dieses Volume im Container unter dem Pfad `/website` (vgl. `nginx-pvc-pod.yaml` aus 05-d-Volumes) [nginx-pvc-pod.yaml](../05-KubernetesObjekte2/05-d-Volumes/nginx-pvc-pod.yaml)
* Deploye das modifizierte nginx-deployment
* Was ist jetzt zu sehen?
  Natürlich immer noch ein 404, das neue Volume ist ja noch leer!

### (c) Manuelles Deployment der Website

* Kopiere den Inhalt des Ordners website in den laufenden Container unter /website/htdocs
* Tip: probiere `kubectl cp`Befehl einmal aus, aber es ist nicht schandhaft jetzt mal kurz in die Lösung zu schauen, der Befehl ist tricky.
* Du kannst das Ergebnis prüfen wenn Du per `kubectl exec` die Verzeichnisse listest.
* Schaue Dir jetzt mal Deine Website im Browser an. 
  Der 404 sollte jetzt einer richtigen Website gewichen sein.

### (d) Automatisches Deployment per InitContainer

* Lösche jetzt einmal das PVC und das Deployment
* Erstelle das PVC neu
* Füge dem nginx Deployment einen InitContainer (mit dem /website Volume) auf Basis des Image `harbor2.csvcdev.vpc.arvato-systems.de/k8s-workshop/git:latest` hinzu der beim Start die folgenden Befehle ausführt:
  ```yaml
        command:
          - "sh"
          - "-c"
          - "cd /website; \
             if [ ! -d k8s-workshop ]; then \ 
               git clone https://github.com/Kube-ASY/k8s-workshop.git ; \ 
               ln -sf k8s-workshop/website htdocs ; \
             else \
               cd k8s-workshop ; \
               git pull ; \
             fi"
  ```
* Rufe die Logs des initContainers ab


### (e) [Optional] SideCar

Füge noch einen SideCar Container hinzu der das website Repo all 5min updated


## Lösungen

### (a)

* Namespace
```yaml
a3ViZWN0bCBjcmVhdGUgbnMgd2Vic2l0ZQoKa3ViZWN0bCBjb25maWcgc2V0LWNvbnRleHQgLS1jdXJyZW50IC0tbmFtZXNwYWNlPXdlYnNpdGUKCmt1YmVjdGwgZGVwbG95IC1mIG5naW54LWNvbmZpZ21hcC55YW1sIC1mIG5naW54LWRlcGxveW1lbnQueWFtbCAtZiBuZ2lueC1zZXJ2aWNlLnlhbWw=
```

* `nginx-ingress.yaml`
```yaml
YXBpVmVyc2lvbjogbmV0d29ya2luZy5rOHMuaW8vdjEKa2luZDogSW5ncmVzcwptZXRhZGF0YToKICBuYW1lOiBuZ2lueC1pbmdyZXNzCiAgbGFiZWxzOgogICAgICBhcHA6IHdlYnNpdGUKc3BlYzoKICBydWxlczoKICAtIGhvc3Q6IHdlYnNpdGUuazhzLXdvcmtzaG9wLmluZm8KICAgIGh0dHA6CiAgICAgIHBhdGhzOgogICAgICAtIHBhdGhUeXBlOiBQcmVmaXgKICAgICAgICBwYXRoOiAiLyIKICAgICAgICBiYWNrZW5kOgogICAgICAgICAgc2VydmljZToKICAgICAgICAgICAgbmFtZTogbmdpbngKICAgICAgICAgICAgcG9ydDogCiAgICAgICAgICAgICAgbmFtZTogaHR0cA==
```

### (b)
* `nginx-website-pvc.yaml`
```yaml
ICBhcGlWZXJzaW9uOiB2MQogIGtpbmQ6IFBlcnNpc3RlbnRWb2x1bWVDbGFpbQogIG1ldGFkYXRhOgogICAgbmFtZTogbmdpbngtd2Vic2l0ZQogIHNwZWM6CiAgICByZXNvdXJjZXM6CiAgICAgIHJlcXVlc3RzOgogICAgICAgIHN0b3JhZ2U6IDFHaQogICAgdm9sdW1lTW9kZTogRmlsZXN5c3RlbQogICAgYWNjZXNzTW9kZXM6CiAgICAgIC0gUmVhZFdyaXRlT25jZQ==
```

* `nginx-deployment-pvc.yaml`
```yaml
ICBhcGlWZXJzaW9uOiBhcHBzL3YxCiAga2luZDogRGVwbG95bWVudAogIG1ldGFkYXRhOgogICAgbmFtZTogbmdpbngKICBzcGVjOgogICAgcmVwbGljYXM6IDEKICAgIHNlbGVjdG9yOgogICAgICBtYXRjaExhYmVsczoKICAgICAgICAgIGFwcDogd2Vic2l0ZQogICAgdGVtcGxhdGU6CiAgICAgIG1ldGFkYXRhOgogICAgICAgIGxhYmVsczoKICAgICAgICAgIGFwcDogd2Vic2l0ZQogICAgICBzcGVjOgogICAgICAgIGNvbnRhaW5lcnM6CiAgICAgICAgLSBuYW1lOiBuZ2lueAogICAgICAgICAgaW1hZ2U6IGhhcmJvcjIuY3N2Y2Rldi52cGMuYXJ2YXRvLXN5c3RlbXMuZGUvazhzLXdvcmtzaG9wL2diLW5naW54OjEuMTkKICAgICAgICAgIGltYWdlUHVsbFBvbGljeTogSWZOb3RQcmVzZW50CiAgICAgICAgICByZXNvdXJjZXM6CiAgICAgICAgICAgIHJlcXVlc3RzOgogICAgICAgICAgICAgIGNwdTogMTBtCiAgICAgICAgICAgICAgbWVtb3J5OiAxMDBNaQogICAgICAgICAgcG9ydHM6CiAgICAgICAgICAtIGNvbnRhaW5lclBvcnQ6IDgwODAKICAgICAgICAgICAgbmFtZTogaHR0cAogICAgICAgICAgdm9sdW1lTW91bnRzOgogICAgICAgICAgICAtIG5hbWU6IG5naW54LWNvbmYKICAgICAgICAgICAgICBtb3VudFBhdGg6IC9vcHQvYml0bmFtaS9uZ2lueC9jb25mL3NlcnZlcl9ibG9ja3MKICAgICAgICAgICAgLSBuYW1lOiB3ZWJzaXRlCiAgICAgICAgICAgICAgbW91bnRQYXRoOiAvd2Vic2l0ZQogICAgICAgIHZvbHVtZXM6CiAgICAgICAgICAtIG5hbWU6IG5naW54LWNvbmYKICAgICAgICAgICAgY29uZmlnTWFwOiAKICAgICAgICAgICAgICBuYW1lOiBuZ2lueC1jb25maWcKICAgICAgICAgICAgICBpdGVtczoKICAgICAgICAgICAgICAtIGtleTogdmhvc3QuY29uZgogICAgICAgICAgICAgICAgcGF0aDogd2Vic2l0ZS12aG9zdC5jb25mCiAgICAgICAgICAtIG5hbWU6IHdlYnNpdGUKICAgICAgICAgICAgcGVyc2lzdGVudFZvbHVtZUNsYWltOgogICAgICAgICAgICAgIGNsYWltTmFtZTogbmdpbngtd2Vic2l0ZQ==
```

### (c)
* kubectl cp 
  ```bash
  kubectl cp website <POD>:/website/htdocs
  ```

### (d)
* cleanup
  ```bash
  kubectl delete pvc nginx-website
  kubectl delete deployment nginx
  kubectl get pvc, pods
  ```
* nginx-deployment-init.yaml
  ```yaml
  ICBhcGlWZXJzaW9uOiBhcHBzL3YxCiAga2luZDogRGVwbG95bWVudAogIG1ldGFkYXRhOgogICAgbmFtZTogbmdpbngKICBzcGVjOgogICAgcmVwbGljYXM6IDEKICAgIHNlbGVjdG9yOgogICAgICBtYXRjaExhYmVsczoKICAgICAgICAgIGFwcDogd2Vic2l0ZQogICAgdGVtcGxhdGU6CiAgICAgIG1ldGFkYXRhOgogICAgICAgIGxhYmVsczoKICAgICAgICAgIGFwcDogd2Vic2l0ZQogICAgICBzcGVjOgogICAgICAgIGluaXRDb250YWluZXJzOgogICAgICAgIC0gbmFtZTogZ2l0CiAgICAgICAgICBpbWFnZTogaGFyYm9yMi5jc3ZjZGV2LnZwYy5hcnZhdG8tc3lzdGVtcy5kZS9rOHMtd29ya3Nob3AvZ2l0OmxhdGVzdAogICAgICAgICAgaW1hZ2VQdWxsUG9saWN5OiBJZk5vdFByZXNlbnQKICAgICAgICAgIGNvbW1hbmQ6CiAgICAgICAgICAgIC0gInNoIgogICAgICAgICAgICAtICItYyIKICAgICAgICAgICAgLSAiY2QgL3dlYnNpdGU7IFwKICAgICAgICAgICAgICBpZiBbICEgLWQgazhzLXdvcmtzaG9wIF07IHRoZW4gXCAKICAgICAgICAgICAgICBnaXQgY2xvbmUgaHR0cHM6Ly9naXRodWIuY29tL0t1YmUtQVNZL2s4cy13b3Jrc2hvcC5naXQgOyBcIAogICAgICAgICAgICAgIGxuIC1zZiBrOHMtd29ya3Nob3Avd2Vic2l0ZSBodGRvY3MgOyBcCiAgICAgICAgICAgICAgZWxzZSBcCiAgICAgICAgICAgICAgY2QgazhzLXdvcmtzaG9wIDsgXAogICAgICAgICAgICAgIGdpdCBwdWxsIDsgXAogICAgICAgICAgICAgIGZpIgogICAgICAgICAgdm9sdW1lTW91bnRzOgogICAgICAgICAgICAtIG5hbWU6IHdlYnNpdGUKICAgICAgICAgICAgICBtb3VudFBhdGg6IC93ZWJzaXRlICAgICAgICAgICAgCiAgICAgICAgY29udGFpbmVyczoKICAgICAgICAtIG5hbWU6IG5naW54CiAgICAgICAgICBpbWFnZTogaGFyYm9yMi5jc3ZjZGV2LnZwYy5hcnZhdG8tc3lzdGVtcy5kZS9rOHMtd29ya3Nob3AvZ2Itbmdpbng6MS4xOQogICAgICAgICAgaW1hZ2VQdWxsUG9saWN5OiBJZk5vdFByZXNlbnQKICAgICAgICAgIHJlc291cmNlczoKICAgICAgICAgICAgcmVxdWVzdHM6CiAgICAgICAgICAgICAgY3B1OiAxMG0KICAgICAgICAgICAgICBtZW1vcnk6IDEwME1pCiAgICAgICAgICBwb3J0czoKICAgICAgICAgIC0gY29udGFpbmVyUG9ydDogODA4MAogICAgICAgICAgICBuYW1lOiBodHRwCiAgICAgICAgICB2b2x1bWVNb3VudHM6CiAgICAgICAgICAgIC0gbmFtZTogbmdpbngtY29uZgogICAgICAgICAgICAgIG1vdW50UGF0aDogL29wdC9iaXRuYW1pL25naW54L2NvbmYvc2VydmVyX2Jsb2NrcwogICAgICAgICAgICAtIG5hbWU6IHdlYnNpdGUKICAgICAgICAgICAgICBtb3VudFBhdGg6IC93ZWJzaXRlCiAgICAgICAgdm9sdW1lczoKICAgICAgICAgIC0gbmFtZTogbmdpbngtY29uZgogICAgICAgICAgICBjb25maWdNYXA6IAogICAgICAgICAgICAgIG5hbWU6IG5naW54LWNvbmZpZwogICAgICAgICAgICAgIGl0ZW1zOgogICAgICAgICAgICAgIC0ga2V5OiB2aG9zdC5jb25mCiAgICAgICAgICAgICAgICBwYXRoOiB3ZWJzaXRlLXZob3N0LmNvbmYKICAgICAgICAgIC0gbmFtZTogd2Vic2l0ZQogICAgICAgICAgICBwZXJzaXN0ZW50Vm9sdW1lQ2xhaW06CiAgICAgICAgICAgICAgY2xhaW1OYW1lOiBuZ2lueC13ZWJzaXRl
  ```

  
