# Persistent Volumes

## Static

### manual PV
```ỳaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: static-www
  labels:
    type: local
    pv: static-www
spec:
  storageClassName: manual
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/srv/www/html-static"
    type: DirectoryOrCreate
```

* `kubectl apply -f static-pv.yaml`
* `kubectl get pv`

### use via PVC
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: static-www-claim
spec:
  storageClassName: manual
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
  selector:
    matchLabels:
      pv: static-www
```
* `kubectl apply -f static-pvc.yaml`
* `kubectl get pvc`

### use it in Pod
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pvc-pod
spec:
  volumes:
    - name: static-www
      persistentVolumeClaim:
        claimName: static-www-claim
  containers:
    - name: nginx
      image: nginx
      ports:
        - containerPort: 80
          name: http
      volumeMounts:
        - mountPath: "/usr/share/nginx/html"
          name: static-www
```

## dynamic PVC
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: dynamic-www-claim
spec:
  storageClassName: standard
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
```

* `kubectl get pvc`
* `kubectl get pv`
* `kubectl get pv -o yaml`
* `kubectl get storageclass`
* `kubectl get storageclass -o yaml`
* `kubectl -n kube-system get pods`


## StatefulSets mit PVC

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: nginx-pvc
spec:
  selector:
    matchLabels:
      app: nginx
  serviceName: nginx
  replicas: 2
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 80
          name: http
        volumeMounts:
        - name: www
          mountPath: /usr/share/nginx/html
  volumeClaimTemplates:
  - metadata:
      name: www
    spec:
      accessModes: [ "ReadWriteOnce" ]
      storageClassName: standard
      resources:
        requests:
          storage: 1Gi
```

* `kubectl apply -f nginx-pvc-sts.yaml`
* `kubectl get pods`
* `kubectl get pvc`
* `kubectl delete sts nginx-pvc`
* `kubectl get pvc`
