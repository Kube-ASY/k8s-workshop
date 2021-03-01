# Pods

## Create Pod with kubectl

Nur über kubectl run

    kubectl run hello-app --image=harbor2.csvcdev.vpc.arvato-systems.de/k8s-workshop/hello-app:1.0

    kubectl get pods

    kubectl delete pod hello-app

## Create Pod über YAML Manifest

    kubectl apply -f hello-pod.yaml


## YAML Code

```yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    app: hello
  name: hello-app
  namespace: k8s-workshop
spec:
  initContainers: []
  containers:
  - image: harbor2.csvcdev.vpc.arvato-systems.de/k8s-workshop/hello-app:1.0
    imagePullPolicy: IfNotPresent
    name: hello-app
    volumeMounts: []  
  restartPolicy: Always
  securityContext: {}
  serviceAccount: default
  serviceAccountName: default
  terminationGracePeriodSeconds: 30
  tolerations: []
  volumes: []
```