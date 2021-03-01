# StatefulSet

Erstellen eines Redis Replication Setup mit StatefulSet

## YAML

### Master vs. Follower ConfigMap
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: redis
data:
  master.conf: |
    bind 0.0.0.0
    protected-mode yes
    port 6379
  follower.conf: |
    replicaof redis-0.redis 6379
```
### Service
```yaml
apiVersion: v1
kind: Service
metadata:
  name: redis
  labels:
    app: redis
spec:
  type: ClusterIP
  ports:
  - name: redis
    port: 6379
    targetPort: redis
  clusterIP: None
  selector:
    app: redis
```

### StatefulSet
```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: redis
spec:
  serviceName: "redis"
  replicas: 2
  selector:
    matchLabels:
      app: redis
  template:
    metadata:
      labels:
        app: redis
    spec:
      initContainers:
      - name: init-redis
        image: harbor2.csvcdev.vpc.arvato-systems.de/k8s-workshop/redis:6.0
        command:
        - bash
        - "-c"
        - |
          set -ex
          # Generate redis server-id from pod ordinal index.
          [[ `hostname` =~ -([0-9]+)$ ]] || exit 1
          ordinal=${BASH_REMATCH[1]}
          # Copy appropriate conf.d files from config-map to emptyDir.
          if [[ $ordinal -eq 0 ]]; then
            cp /mnt/config-map/master.conf /etc/redis.conf
          else
            cp /mnt/config-map/follower.conf /etc/redis.conf
          fi
        volumeMounts:
        - name: conf
          mountPath: /etc
          subPath: redis.conf
        - name: config-map
          mountPath: /mnt/config-map
      containers:
      - name: redis
        image: harbor2.csvcdev.vpc.arvato-systems.de/k8s-workshop/redis:6.0
        command:
          - "redis-server"
          - "/etc/redis.conf"
        resources:
          requests:
            cpu: 100m
            memory: 100Mi
        ports:
        - name: redis
          containerPort: 6379
        volumeMounts:
        - name: conf
          mountPath: /etc
          subPath: redis.conf
        - name: redis-data
          mountPath: /data
      volumes:
        - name: conf
          emptyDir: {}
        - name: redis-data
          emptyDir: {}
        - name: config-map
          configMap:
            name: redis
```

### Ergebnis
* Master erreichbar unter redis-0.redis (automatischer DNS Eintrag für StatefulSet Container)
* Über den Service (redis) Zugang auf alle Container (read-only)
