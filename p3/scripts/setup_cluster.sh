#!/bin/bash
set -euo pipefail

echo -e "===== Creating cluster using k3d =====\n"
k3d cluster create argocd \
  --servers 1 \
  --agents 1 \
  --servers-memory 4g \
  --agents-memory 4g \
  --port "8888:30080@loadbalancer"


echo -e "\n===== Check kubeconfig after creation =====\n"
export KUBECONFIG="$HOME/.kube/config"

echo -e "\n===== Checking cluster info =====\n"
echo "$(kubectl cluster-info)"

echo -e "\n===== Checking nodes =====\n"
echo "$(kubectl get nodes)"

echo -e "\n===== Checking pods =====\n"
echo "$(kubectl get pods -A)"

echo -e "\n===== Creating Namespaces: Argo CD & dev... =====\n"
kubectl create namespace argocd
kubectl create namespace dev
echo "$(kubectl get namespace)"

echo -e "\n===== Installing Argo CD & Argo CD CLI... =====\n"
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
echo "$(argocd version)"

echo -e "\n===== Check all Argo CD pods are running... =====\n"
kubectl get pods -n argocd

echo -e "\n===== Access argo cd locally by exposing the Port... =====\n"
kubectl patch svc argocd  -server -n argocd -p '{"spec": {"type": "NodePort", "ports": [{"port": 80,"targetPort": 8080,"nodePort": 30080,"name": "http"},{"port": 443,"targetPort": 8080,"nodePort": 30443,"name": "https"}]}}'

echo -e "\n===== Check health of Argo CD server... =====\n"
curl -v http://localhost:8888/healthz
echo -e "\n===== Check content of Argo CD server... =====\n"
curl -vk http://localhost:8888/healthz

echo -e "\n===== Deploy Argo CD application... =====\n"
kubectl apply -f confs/app.yml

echo -e "\n===== Check application was deployed... =====\n"
kubectl get applications -n argocd
kubectl describe application app -n argocd

# echo -e "\n===== Install Argo CD CLI... =====\n"
# curl -sSL -o argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
# chmod +x argocd
# sudo mv argocd /usr/local/bin/                                              

echo -e "\n===== Logging into Argo CD Server... =====\n"
PASSWORD=$(< kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo)
argocd login localhost:8888 --username admin --password $PASSWORD --insecure
kubectl get svc -n argocd argocd-server
# argocd login localhost:8888 --username admin --password $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d) --insecure

argocd app list
argocd app sync app
argocd app get app
