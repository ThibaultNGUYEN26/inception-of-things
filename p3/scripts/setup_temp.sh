# create cluster
k3d cluster create my-cluster --api-port 6443 -p 8080:80@loadbalancer --agents 2

# check cluster info
kubectl cluster-info

# install argo cd (maybe get newer version)
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl create namespace argocd
kubectl apply -f install.yaml -n argocd

# install argo crds
kubectl apply -k https://github.com/argoproj/argo-cd/manifests/crds\?ref\=stable

# check all pods are running right > if false do not move on
kubectl get pods -n argocd

# create ingress.yml
kubectl apply -f ingress.yml -n argocd

