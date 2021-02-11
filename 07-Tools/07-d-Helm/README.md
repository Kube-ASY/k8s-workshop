# Helm

* Install helm
  ```bash
  sudo snap install helm --classic
  ```

## Chart erstellen

```bash
schulung@schulung-k8s:~$ helm create workshop
Creating workshop

schulung@schulung-k8s:~$ tree workshop
workshop
├── charts
├── Chart.yaml
├── templates
│   ├── deployment.yaml
│   ├── _helpers.tpl
│   ├── hpa.yaml
│   ├── ingress.yaml
│   ├── NOTES.txt
│   ├── serviceaccount.yaml
│   ├── service.yaml
│   └── tests
│       └── test-connection.yaml
└── values.yaml

```

## Chart nutzen

```bash
kubectl create ns helm

# Install a release of the Chart
helm install -n helm workshop-dev ./workshop

# Check Objects
kubectl -n helm get all

# Execute the test
helm test -n helm workshop-dev

# Install another release of the chart but with an Ingress

helm install -n helm workshop-prod ./workshop --set replicaCount=2

# Check Objects
kubectl -n helm get pods,service
```

## Links

* [helm.sh]
* [https://artifacthub.io/]
