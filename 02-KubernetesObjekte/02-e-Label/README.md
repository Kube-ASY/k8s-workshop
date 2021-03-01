# Label und Annotations

## Label

   kubectl label pod hello-app version=1.0 

   kubectl get pods -l version=1.0
## Annotations
    kubectl annotate pod hello-app arvato-systems.de/managed="true"

    kubectl annotate pod hello-app --overwrite arvato-systems.de/managed="false"

**Boolean Werte in Annotations immer in Quotes**

    kubectl annotate pod hello-app arvato-systems.de/managed-


