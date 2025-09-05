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
sudo install -m 555 argocd - linux - amd64 / usr / local / bin / argocd
rm argocd - linux - amd64
echo "$(argocd version)"

echo -e "\n===== Check all Argo CD pods are running... =====\n"
kubectl get pods -n argocd

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml


