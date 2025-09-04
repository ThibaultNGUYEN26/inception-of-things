#!/bin/bash
set -euo pipefail

echo "===== Installing K3s in Controller Mode on the server VM ====="

PRIVATE_IP="192.168.56.110"
SHARED_FOLDER="/home/vagrant/p1"

# --- Install K3s ---
echo ">>> Installing K3s..."
curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" sh -s - \
    server --node-ip "$PRIVATE_IP" --advertise-address "$PRIVATE_IP" --tls-san "$PRIVATE_IP"

# # --- Configure kubeconfig for current user ---
# echo ">>> Configuring kubectl..."
# mkdir -p ~/.kube
# sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
# sudo chown $(id -u):$(id -g) ~/.kube/config

# --- Save node token to .env ---
NODE_TOKEN=$(sudo cat /var/lib/rancher/k3s/server/node-token)
echo "$NODE_TOKEN" > "$SHARED_FOLDER/tokens/node"
echo ">>> Node token saved to $SHARED_FOLDER/tokens/node"

echo -e "===== K3s / Kubectl installation complete in Server VM ====="
