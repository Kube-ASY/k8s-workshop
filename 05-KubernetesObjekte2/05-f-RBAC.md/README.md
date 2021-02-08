# RBAC

Beispiel von RBAC im Container

## default: keine Rechte

* Create a fresh namespace
  ```bash
  kubectl create namespace rbac
  ```
* Run Container with default ServiceAccount
  ```bash
  kubectl apply -f kubectl-default-pod.yaml
  ```
  ```yaml
  apiVersion: v1
  kind: Pod
  metadata:
    labels:
      app: kubectl-default
    name: kubectl-default
    namespace: rbac
  spec:
    containers:
    - image: harbor2.csvcdev.vpc.arvato-systems.de/k8s-workshop/kubectl:1.20.0
      imagePullPolicy: IfNotPresent
      name: kubectl
      command: [ "sleep","3600" ]
    restartPolicy: Always
    serviceAccount: default
    serviceAccountName: default
  ```
* Exec into Container
  ```bash
  kubectl -n rbac exec -it kubectl-default -- sh
  ```
  ```bash
  / # kubectl get pods
  Error from server (Forbidden): pods is forbidden: User "system:serviceaccount:rbac:default" cannot list resource "pods" in API group "" in the namespace "rbac"
  ```

## New ServiceAccount `list`
* Create ServiceAccount, a Role and Bind the Role to the ServiceAccount
  ```bash
  kubectl apply -f list-sa.yaml -f list-role.yaml -f list-rolebinding.yaml
  ```
  ```yaml
  ---
  apiVersion: v1
  kind: ServiceAccount
  metadata:
    name: list
    namespace: rbac
  ---
  apiVersion: rbac.authorization.k8s.io/v1
  kind: Role
  metadata:
    name: list
    namespace: rbac
  rules:
  - apiGroups:
    - ""
    resources:
    - '*'
    verbs:
    - list
  ---
  apiVersion: rbac.authorization.k8s.io/v1
  kind: RoleBinding
  metadata:
    name: list
    namespace: rbac
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: Role
    name: list
  subjects:
  - kind: ServiceAccount
    name: list
    namespace: rbac
  ```
* Start a pod with this ServiceAccount:
  ```bash
  kubectl apply -f kubectl-list-pod.yaml
  ```
  ```yaml
  apiVersion: v1
  kind: Pod
  metadata:
    labels:
      app: kubectl-list
    name: kubectl-list
    namespace: rbac
  spec:
    containers:
    - image: harbor2.csvcdev.vpc.arvato-systems.de/k8s-workshop/kubectl:1.20.0
      imagePullPolicy: IfNotPresent
      name: kubectl
      command: [ "sleep","3600" ]
    restartPolicy: Always
    serviceAccount: list
    serviceAccountName: list
  ```
* Und probieren:
  ```bash
  kubectl -n rbac exec -it kubectl-list -- sh
  / # kubectl get pods
  NAME              READY   STATUS    RESTARTS   AGE
  kubectl-default   1/1     Running   0          13m
  kubectl-list      1/1     Running   0          25s
  / # kubectl get pod kubectl-list  -o yaml
  Error from server (Forbidden): pods "kubectl-list" is forbidden: User "system:serviceaccount:rbac:list" cannot get resource "pods" in API group "" in the namespace "rbac"
  ```
  * list != get (!)

## Cleanup
* `kubectl delete namespace rbac`