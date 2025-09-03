#!/bin/bash
set -euo pipefail

echo "===== Installing K3s in Controller Mode on the server VM ====="

# --- Install K3s ---
echo ">>> Installing K3s..."
curl -sfL https://get.k3s.io | sh -

# --- Configure kubeconfig for current user ---
echo ">>> Configuring kubectl..."
mkdir -p ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown $(id -u):$(id -g) ~/.kube/config

echo -e "\n===== K3s 7 Kubectl installation complete in Server VM ====="
