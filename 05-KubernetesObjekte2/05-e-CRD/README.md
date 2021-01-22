# CRD am Beispiel SealedSecret
Der SealedSecret Controller verschlüsselt Secrets damit man sie z.B. "gefahrlos" in einem GitOps Repository ablegen kann.
Die Entschlüsselung erfolgt erst wieder im Cluster.

* [https://github.com/bitnami-labs/sealed-secrets]

## Install the Operator/Controller
* `./install_controller.sh`
* `kubectl -n kube-system get pods`
* `ls -l kubeseal`

## CRD
* `kubectl get crd`
* ```
  NAME                        CREATED AT
  sealedsecrets.bitnami.com   2021-01-22T13:44:06Z
  ```

## Usage Create a SealedSecret Object
* ```bash
  kubectl -n k8s-workshop create secret generic password  --from-literal=password=geheim --dry-run=client  -o yaml | ./kubeseal --format=yaml >password-sealedsecret.yaml```
* ```yaml
    apiVersion: bitnami.com/v1alpha1
    kind: SealedSecret
    metadata:
    creationTimestamp: null
    name: password
    namespace: k8s-workshop
    spec:
    encryptedData:
        password: AgDRhVpsVU7KrhMXRZcvbcDo3sxMZYoc+1BEJnBvIrGIsRs4cyeCRlXFXfQ2nEGJaPHlO/LPa9J1WZqKwJopSSOQqnC5gGt3MernzSYObahOxh3E+Et83Pqw4AYcbU1E/M60e7+wbEGwXHDZVUkSPzOB5OF47/SwGWdsOcPSm6MAAGrUl7DgjAeSe8bWGGaDwEkKigEqQ+/zL4g4mTi3lCD+TH56/ijL8xo4n2JRJuHuEWilz09K24x6KdC+fFej8nQh68fTeThgGqlJo0qiGCC7izZJx583lt++BSk3kHvjIvyWXSTdj+xcvoIILTYHm3lCJbuVkiaWVwrhkDL+/0WlMmg6J97dUffw+zdkfH3npGUJAFWeXWJX9tMFNxJRg3VxDydMCXcjzTvp89NgpWq9QZ9N/kBBj7pa6FtIqtECrwMMmFM3ctyp8AMEmbZ+TO/C/2C4dgPEHjBwoHqRaiBWwCoilIysqju5gthoKsMT+v1dJ2ZVBv8sjGDCuE+Le38pmyIGWxeX2CfQDbQ3osNX5v4ggzHF/tE0FgqmuANTc4Pa56UiMPYK+sV+1O1KAvdt5Rnyy1iOkhgZ7GLqcUvpfdXpfZMH5LYiQ+4RR8Pa0iYUWnyxdX3SFesPvLWerGtZTwUmuEpWf3PeJ2VyTunHjgLKHeuT7XVs1jluR9UkRSSX1BjPhLr4mjkszTiinSqG/g3O/Jg=
    template:
        metadata:
        creationTimestamp: null
        name: password
        namespace: k8s-workshop
    ```
* `kubectl apply -f password-sealedsecret.yaml`
* `kubectl get sealedsecret`
* `kubectl get secret`