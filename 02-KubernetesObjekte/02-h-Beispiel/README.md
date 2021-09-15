# Komplexes Beispiel Deployment

* 3 Tier
  * nginx Reverse Proxy + Static Content
  * PHP-FPM (AppServer
  * Redis Leader/Follower DB
  
## Redis Cluster

* 2 Deployments unterscheiden sich nicht im Container, nur in den ARGS
* Zugriff über jeweilige Services
  
## PHPFPM

* Basis Container + App als Addon

## nginx

* vhost Config aus ConfigMap

# Setup

## Namespace + Objekte installieren

```bash
./create-namespace.sh

kubectl apply -f .

watch kubectl get pods,deployment,service
```

## Objekte erforschen

* wie funktioniert der Redis Cluster (Container Command + Args )
* Wie funktioniert das Deployment (-> Umgebungsvariable)
* Wie funktioniert der Proxy (ConfigMap Volume)

# Cleanup

`./cleanup.sh`