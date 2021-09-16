# Übungen 2

## Hinweis

Diese Übungen sind für den Erstkontakt vielleicht schon etwas zu herausfordernd.
Wenn Du nicht sofort weißt, was zu tun ist, ist es absolut in Ordnung die Lösungen zu entschlüsseln und nachzuvollziehen.
Auch dabei entwickelt man ein Gefühl für die Arbeit mit einem Kubernetes Cluster. 
Wenn Du nicht nur Cut'n Paste machen willst kannst du ja die Befehle teilweise abtippen.

## Hosting a Website with nginx

Wir nehmen den nginx aus dem Guestbook Example und verwenden ihn um eine statische Website zu hosten.

Im Ordner befinden sich
* `nginx-deployment.yaml`
* `nginx-configmap.yaml`
* `nginx-service.yaml`

### (a) Basis Deplyoment + Ingress
* Erstelle einen Namespace `website` und deploye diese Komponenten darin.
* Setze den Current-Context deiner kubectl config auf diesen Namespace (siehe Übung 1)

* Erstelle wie in [05-g-Ingress](../05-KubernetesObjekte2/5-g-Ingress/) beschrieben einen Ingress und einen `/etc/hosts` Eintrag um auf den nginx mittels der URL `website.k8s-workshop.info` zuzugreifen. (http reicht)
* Passe zum z.B. diesen Ingress aus der Demonstration entsprechend an:
    * Konfiguriere den richtigen Hostnamen (URL)
    * Ermittle Namen und Port des Service der angsprochen werden soll
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
  * Oder manuell in die /etc/hosts eintragen (`sudo vi`)

*Wenn hier ein HTTP-404 kommt ist alles OK*

Tip: Schau in die Logs des Containers. 
Scheint wohl einfach noch kein Content vorhanden zu sein. 
Darum kümmern wir uns jetzt.


### (b) Ein Volume die Website zu hosten
* Erstelle jetzt ein PVC (PersistentVolumeClaim) mit Namen `nginx-website` und 1GB Größe und der StorageClass `standard`  siehe dynamic-www-pvc.yaml in [dynamic-www-pvc.yaml](../05-KubernetesObjekte2/05-d-Volumes/dynamic-www-pvc.yaml)
* Modifizieren das `nginx-deployment.yaml` und mounte den Inhalt dieses Volume im Container unter dem Pfad `/website` (vgl. `nginx-pvc-pod.yaml` aus 05-d-Volumes) [nginx-pvc-pod.yaml](../05-KubernetesObjekte2/05-d-Volumes/nginx-pvc-pod.yaml)
* Deploye das modifizierte nginx-deployment
* Was ist jetzt zu sehen?
  => Natürlich immer noch ein 404, das neue Volume ist ja noch leer!

### (c) Manuelles Deployment der Website

* Kopiere den Inhalt des Ordners `website` im Root des Repos (`~/k8s-workshop/website`) in den laufenden Container unter `/website/htdocs`
* Tip: probiere `kubectl cp` Befehl einmal aus, aber es ist nicht schandhaft jetzt mal kurz in die Lösung zu schauen, der Befehl ist tricky.
* Du kannst das Ergebnis prüfen wenn Du per `kubectl exec` die Verzeichnisse im Container listest.
* Schaue Dir jetzt mal Deine Website im Browser an. 
  => Der 404 sollte jetzt einer richtigen Website gewichen sein.

### (d) Automatisches Deployment per InitContainer

* Lösche jetzt einmal das PVC und das Deployment
* Erstelle das PVC neu
* Füge dem nginx Deployment einen InitContainer (mit dem /website Volume) auf Basis des Image `harbor.csvcdev.vpc.arvato-systems.de/k8s-workshop/git:latest` hinzu der beim Start die folgenden Befehle ausführt:
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
a3ViZWN0bCBjcmVhdGUgbnMgd2Vic2l0ZQoKa3ViZWN0bCBjb25maWcgc2V0LWNvbnRleHQgLS1jdXJyZW50IC0tbmFtZXNwYWNlPXdlYnNpdGUKCmt1YmVjdGwgYXBwbHkgLWYgbmdpbngtY29uZmlnbWFwLnlhbWwgLWYgbmdpbngtZGVwbG95bWVudC55YW1sIC1mIG5naW54LXNlcnZpY2UueWFtbA==
```

* `nginx-ingress.yaml`
```yaml
YXBpVmVyc2lvbjogbmV0d29ya2luZy5rOHMuaW8vdjEKa2luZDogSW5ncmVzcwptZXRhZGF0YToKICBuYW1lOiBuZ2lueC1pbmdyZXNzCiAgbGFiZWxzOgogICAgICBhcHA6IHdlYnNpdGUKc3BlYzoKICBydWxlczoKICAgIC0gaG9zdDogd2Vic2l0ZS5rOHMtd29ya3Nob3AuaW5mbwogICAgICBodHRwOgogICAgICAgIHBhdGhzOgogICAgICAgICAgLSBwYXRoVHlwZTogUHJlZml4CiAgICAgICAgICAgIHBhdGg6ICIvIgogICAgICAgICAgICBiYWNrZW5kOgogICAgICAgICAgICAgIHNlcnZpY2U6CiAgICAgICAgICAgICAgICBuYW1lOiBuZ2lueAogICAgICAgICAgICAgICAgcG9ydDogCiAgICAgICAgICAgICAgICAgIG5hbWU6IGh0dHA=
```

### (b)
* `nginx-website-pvc.yaml`
```yaml
ICBhcGlWZXJzaW9uOiB2MQogIGtpbmQ6IFBlcnNpc3RlbnRWb2x1bWVDbGFpbQogIG1ldGFkYXRhOgogICAgbmFtZTogbmdpbngtd2Vic2l0ZQogIHNwZWM6CiAgICByZXNvdXJjZXM6CiAgICAgIHJlcXVlc3RzOgogICAgICAgIHN0b3JhZ2U6IDFHaQogICAgdm9sdW1lTW9kZTogRmlsZXN5c3RlbQogICAgYWNjZXNzTW9kZXM6CiAgICAgIC0gUmVhZFdyaXRlT25jZQ==
```

* `nginx-deployment-pvc.yaml`
```yaml
ICBhcGlWZXJzaW9uOiBhcHBzL3YxCiAga2luZDogRGVwbG95bWVudAogIG1ldGFkYXRhOgogICAgbmFtZTogbmdpbngKICBzcGVjOgogICAgcmVwbGljYXM6IDEKICAgIHNlbGVjdG9yOgogICAgICBtYXRjaExhYmVsczoKICAgICAgICAgIGFwcDogd2Vic2l0ZQogICAgdGVtcGxhdGU6CiAgICAgIG1ldGFkYXRhOgogICAgICAgIGxhYmVsczoKICAgICAgICAgIGFwcDogd2Vic2l0ZQogICAgICBzcGVjOgogICAgICAgIGNvbnRhaW5lcnM6CiAgICAgICAgICAtIG5hbWU6IG5naW54CiAgICAgICAgICAgIGltYWdlOiBoYXJib3IyLmNzdmNkZXYudnBjLmFydmF0by1zeXN0ZW1zLmRlL2s4cy13b3Jrc2hvcC9nYi1uZ2lueDoxLjIxCiAgICAgICAgICAgIGltYWdlUHVsbFBvbGljeTogSWZOb3RQcmVzZW50CiAgICAgICAgICAgIHJlc291cmNlczoKICAgICAgICAgICAgICByZXF1ZXN0czoKICAgICAgICAgICAgICAgIGNwdTogMTBtCiAgICAgICAgICAgICAgICBtZW1vcnk6IDEwME1pCiAgICAgICAgICAgIHBvcnRzOgogICAgICAgICAgICAgIC0gY29udGFpbmVyUG9ydDogODA4MAogICAgICAgICAgICAgICAgbmFtZTogaHR0cAogICAgICAgICAgICB2b2x1bWVNb3VudHM6CiAgICAgICAgICAgICAgLSBuYW1lOiBuZ2lueC1jb25mCiAgICAgICAgICAgICAgICBtb3VudFBhdGg6IC9vcHQvYml0bmFtaS9uZ2lueC9jb25mL3NlcnZlcl9ibG9ja3MKICAgICAgICAgICAgICAtIG5hbWU6IHdlYnNpdGUKICAgICAgICAgICAgICAgIG1vdW50UGF0aDogL3dlYnNpdGUKICAgICAgICB2b2x1bWVzOgogICAgICAgICAgLSBuYW1lOiBuZ2lueC1jb25mCiAgICAgICAgICAgIGNvbmZpZ01hcDogCiAgICAgICAgICAgICAgbmFtZTogbmdpbngtY29uZmlnCiAgICAgICAgICAgICAgaXRlbXM6CiAgICAgICAgICAgICAgICAtIGtleTogdmhvc3QuY29uZgogICAgICAgICAgICAgICAgICBwYXRoOiB3ZWJzaXRlLXZob3N0LmNvbmYKICAgICAgICAgIC0gbmFtZTogd2Vic2l0ZQogICAgICAgICAgICBwZXJzaXN0ZW50Vm9sdW1lQ2xhaW06CiAgICAgICAgICAgICAgY2xhaW1OYW1lOiBuZ2lueC13ZWJzaXRl
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
ICBhcGlWZXJzaW9uOiBhcHBzL3YxCiAga2luZDogRGVwbG95bWVudAogIG1ldGFkYXRhOgogICAgbmFtZTogbmdpbngKICBzcGVjOgogICAgcmVwbGljYXM6IDEKICAgIHNlbGVjdG9yOgogICAgICBtYXRjaExhYmVsczoKICAgICAgICAgIGFwcDogd2Vic2l0ZQogICAgdGVtcGxhdGU6CiAgICAgIG1ldGFkYXRhOgogICAgICAgIGxhYmVsczoKICAgICAgICAgIGFwcDogd2Vic2l0ZQogICAgICBzcGVjOgogICAgICAgIGluaXRDb250YWluZXJzOgogICAgICAgICAgLSBuYW1lOiBnaXQKICAgICAgICAgICAgaW1hZ2U6IGhhcmJvcjIuY3N2Y2Rldi52cGMuYXJ2YXRvLXN5c3RlbXMuZGUvazhzLXdvcmtzaG9wL2dpdDpsYXRlc3QKICAgICAgICAgICAgaW1hZ2VQdWxsUG9saWN5OiBJZk5vdFByZXNlbnQKICAgICAgICAgICAgY29tbWFuZDoKICAgICAgICAgICAgICAtICJzaCIKICAgICAgICAgICAgICAtICItYyIKICAgICAgICAgICAgICAtICJjZCAvd2Vic2l0ZTsgXAogICAgICAgICAgICAgICAgaWYgWyAhIC1kIGs4cy13b3Jrc2hvcCBdOyB0aGVuIFwgCiAgICAgICAgICAgICAgICBnaXQgY2xvbmUgaHR0cHM6Ly9naXRodWIuY29tL0t1YmUtQVNZL2s4cy13b3Jrc2hvcC5naXQgOyBcIAogICAgICAgICAgICAgICAgbG4gLXNmIGs4cy13b3Jrc2hvcC93ZWJzaXRlIGh0ZG9jcyA7IFwKICAgICAgICAgICAgICAgIGVsc2UgXAogICAgICAgICAgICAgICAgY2QgazhzLXdvcmtzaG9wIDsgXAogICAgICAgICAgICAgICAgZ2l0IHB1bGwgOyBcCiAgICAgICAgICAgICAgICBmaSIKICAgICAgICAgICAgdm9sdW1lTW91bnRzOgogICAgICAgICAgICAgIC0gbmFtZTogd2Vic2l0ZQogICAgICAgICAgICAgICAgbW91bnRQYXRoOiAvd2Vic2l0ZSAgICAgICAgICAgIAogICAgICAgIGNvbnRhaW5lcnM6CiAgICAgICAgICAtIG5hbWU6IG5naW54CiAgICAgICAgICAgIGltYWdlOiBoYXJib3IyLmNzdmNkZXYudnBjLmFydmF0by1zeXN0ZW1zLmRlL2s4cy13b3Jrc2hvcC9nYi1uZ2lueDoxLjIxCiAgICAgICAgICAgIGltYWdlUHVsbFBvbGljeTogSWZOb3RQcmVzZW50CiAgICAgICAgICAgIHJlc291cmNlczoKICAgICAgICAgICAgICByZXF1ZXN0czoKICAgICAgICAgICAgICAgIGNwdTogMTBtCiAgICAgICAgICAgICAgICBtZW1vcnk6IDEwME1pCiAgICAgICAgICAgIHBvcnRzOgogICAgICAgICAgICAgIC0gY29udGFpbmVyUG9ydDogODA4MAogICAgICAgICAgICAgICAgbmFtZTogaHR0cAogICAgICAgICAgICB2b2x1bWVNb3VudHM6CiAgICAgICAgICAgICAgLSBuYW1lOiBuZ2lueC1jb25mCiAgICAgICAgICAgICAgICBtb3VudFBhdGg6IC9vcHQvYml0bmFtaS9uZ2lueC9jb25mL3NlcnZlcl9ibG9ja3MKICAgICAgICAgICAgICAtIG5hbWU6IHdlYnNpdGUKICAgICAgICAgICAgICAgIG1vdW50UGF0aDogL3dlYnNpdGUKICAgICAgICB2b2x1bWVzOgogICAgICAgICAgLSBuYW1lOiBuZ2lueC1jb25mCiAgICAgICAgICAgIGNvbmZpZ01hcDogCiAgICAgICAgICAgICAgbmFtZTogbmdpbngtY29uZmlnCiAgICAgICAgICAgICAgaXRlbXM6CiAgICAgICAgICAgICAgLSBrZXk6IHZob3N0LmNvbmYKICAgICAgICAgICAgICAgIHBhdGg6IHdlYnNpdGUtdmhvc3QuY29uZgogICAgICAgICAgLSBuYW1lOiB3ZWJzaXRlCiAgICAgICAgICAgIHBlcnNpc3RlbnRWb2x1bWVDbGFpbToKICAgICAgICAgICAgICBjbGFpbU5hbWU6IG5naW54LXdlYnNpdGU=
  ```

  
