kubectl create ns kubectl-demo

kubectl config set-context --current --namespace=kubectl-demo

kubectl apply -f ../02-KubernetesObjekte/02-h-Beispiel/
