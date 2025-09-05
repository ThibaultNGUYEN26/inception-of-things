#!/bin/bash
set -euo pipefail

echo -e "===== Creating cluster using k3d =====\n"
k3d cluster create argocd-cluster \
  --servers 1 \
  --agents 1 \
  --port "8888:30080@loadbalancer" \
  --port "8080:30081@loadbalancer"


echo -e "\n===== Check kubeconfig after creation =====\n"
echo "$(k3d kubeconfig get argocd-cluster)"
export KUBECONFIG=$(k3d kubeconfig get argocd-cluster)

echo -e "\n===== Checking cluster info =====\n"
echo "$(kubectl cluster-info)"

echo -e "\n===== Checking nodes =====\n"
echo "$(kubectl get nodes)"

echo -e "\n===== Checking pods =====\n"
echo "$(kubectl get pods -A)"
