# Secrets

## YAML Code

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: nginx-auth
data:
  auth: dXNlcjokYXByMSR6Skt3Y0F0RyR1SzUxTlFxMVl6ODFyRmJvRjlid1kvCg==
---
apiVersion: v1
kind: Secret
metadata:
  name: nginx-auth2
stringData:
  auth: user:$apr1$zJKwcAtG$uK51NQq1Yz81rFboF9bwY/
---
```
## Usage as Volume Mount

```yaml
spec:
  containers:
  - image: nginx:1.19
    name: nginx
    volumeMounts: 
      - name: auth-volume
        mountPath: /mnt/nginx-auth
  volumes:
    - name: auth-volume
      configMap:
        name: nginx-auth
```