# create cluster
k3d cluster create my-cluster --api-port 6443 -p 8888:80@loadbalancer -p 32443:32443@loadbalancer --agents 2

# check cluster info
kubectl cluster-info

# install argo cd (maybe get newer version)
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# install argo crds
kubectl apply -k https://github.com/argoproj/argo-cd/manifests/crds\?ref\=stable

# check all pods are running right > if false do not move on
kubectl get pods -n argocd

# create ingress.yml
kubectl apply -f confs/ingress.yml -n argocd

# Connect by port forwarding
kubectl port-forward svc/argocd-server -n argocd 8443:443

# Deploy App using argocd
kubectl create namespace dev
kubectl apply -f confs/app.yml -n argocd

# Check state
kubectl get all -n dev

# Log in argocd (doesn't work rn)
PASSWORD=$(< kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo)
argocd login localhost:8888 --username admin --password $PASSWORD --insecure
kubectl get svc -n argocd argocd-server
# Check app is deployed by argo cd
argocd app list

kubectl get ingress -n dev

# check it works with correct version
curl http://localhost:8080/app

# change version and check again