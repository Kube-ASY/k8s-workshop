kubectl create ns k8s-workshop

kubectl config set-context --current --namespace=k8s-workshop

kubectl apply -f ../02-KubernetesObjekte/02-h-Beispiel/
