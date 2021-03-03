# imagePullSecrets

Credentials für den Zugriff auf private Container Registrys werden über
Secrets vom Typ `docker-registry`

## Create Secret

```bash
kubectl create secret docker-registry myregistrykey \
  --docker-server=harbor2.csvcdev.vpc.arvato-systems.de \
  --docker-username='robot$private' \
  --docker-password=$RPWD
```

## Usage
```yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    app: busybox
  name: busybox
  namespace: k8s-workshop
spec:
  imagePullSecrets:
    - name: myregistrykey
  containers:
  - image: harbor2.csvcdev.vpc.arvato-systems.de/k8s-workshop-private/busybox:latest
    imagePullPolicy: Always
    name: busybox
    command:
      - "sleep"
      - "300"
  restartPolicy: Always
```

## Se

## Erstellen und verwenden eines ServiceAccounts mit konfiguriertem imagePullSecret

`kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "myregistrykey"}]}' `