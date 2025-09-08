# create cluster
k3d cluster create my-cluster --api-port 6443 -p 8080:80@loadbalancer --agents 2

# check cluster info
kubectl cluster-info

# install argo cd (maybe get newer version)
wget https://github.com/argoproj/argo-cd/raw/v1.6.2/manifests/install.yaml

kubectl create namespace argocd
kubectl apply -f install.yaml -n argocd

# install argo crds
kubectl apply -k https://github.com/argoproj/argo-cd/manifests/crds\?ref\=stable

# add --insecure and --rootpath and - /argocd in install.yaml after  –staticassets 

# create ingress.yml
kubectl apply -f ingress.yml -n argocd