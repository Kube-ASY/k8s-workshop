# Kustomize / Kustomization

## Object Generator
* Ordner `app`
  * deployment.yaml
  * service.yaml
  * vhost.conf
  
* In der kustomization.yaml wird aus der vhost.conf eine ConfigMap generiert:

```yaml
configMapGenerator:
- name: nginx-config
  files:
  - vhost.conf
resources:
- nginx-deployment.yaml
- nginx-service.yaml
```

* Zusätzlich wird im Deployment der verweis auf die ConfigMap nginx-conf auf den Namen der generierten ConfigMap gesetzt.

* Testing
  ```bash
  kubectl kustomize app
  ```

## Base / Overlay

* Overlay Verzeichnis `dev`
* kustomization.yaml 
  * verweist auf base (`app`)
  * setzt den Namespace auf `dev`
  * fügt einen Prefix `dev-` für alle Objekte eine
  * setzt den Label `environment=dev`
  * und Patches zur Modifikation:
    * latest Tag für das Image
    * reduzierte Resource requests
  