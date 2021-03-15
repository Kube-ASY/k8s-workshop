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
    image: harbor.csvcdev.vpc.arvato-systems.de/k8s-workshop/hello-php:1.0
    ports:
    - containerPort: 80
    env:
      - name: HELLO_MESSAGE
        valueFrom:
          configMapKeyRef:
            name: helloweb-conf
            key: welcome_message

```

## Usage as mounted file

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: gb-nginx-config
data:
  gb-vhost.conf: | 
    server {
      listen 0.0.0.0:8080;
      server_name guestbook.example.com;

      root /app;
      index index.html;

      location / {
        try_files $uri $uri/ /index.php?q=$uri&$args;
      }

      location ~ \.php$ {
        fastcgi_pass localhost:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
        }
    }
```


```yaml
spec:
  containers:
  - name: nginx
    image: harbor.csvcdev.vpc.arvato-systems.de/k8s-workshop/gb-nginx:1.19
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
          path: gb-vhost.conf
```