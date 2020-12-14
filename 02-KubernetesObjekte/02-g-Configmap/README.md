# ConfigMaps

## YAML Code

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: helloweb-conf
data:
  welcome_message: "Hello Kubernauts!"
```

## Usage as Environment Variable
```yaml
[...]
spec:
  containers:
  - name: hello-app
    image: harbor2.csvcdev.vpc.arvato-systems.de/k8s-workshop/hello-php:1.0
    ports:
    - containerPort: 80
    env:
      - name: WELCOME_MESSAGE
        valueFrom:
          configMapKeyRef:
            name: helloweb-conf
            key: welcome_message

```

## Usage as mounted file
```yaml
spec:
  containers:
  - name: nginx
    image: harbor2.csvcdev.vpc.arvato-systems.de/k8s-workshop/gb-nginx:1.19
    imagePullPolicy: Always
    resources:
      requests:
        cpu: 100m
        memory: 100Mi
    ports:
    - containerPort: 8080
      name: http
    volumeMounts:
      - name: nginx-conf
        mountPath: /opt/bitnami/nginx/conf/server_blocks
  volumes:
    - name: nginx-conf
      configMap: 
        name: gb-nginx-config
        items:
        - key: gb-vhost.conf
          path: gb-vhost.conf%      
```