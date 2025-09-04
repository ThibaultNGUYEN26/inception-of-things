#!/bin/bash
set -euo pipefail

echo "===== Installing K3s in Controller Mode on the server VM ====="

PRIVATE_IP="192.168.56.110"

# --- Install K3s ---
echo ">>> Installing K3s..."
curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" sh -s - \
    server --node-ip "$PRIVATE_IP" --advertise-address "$PRIVATE_IP" --tls-san "$PRIVATE_IP"

echo -e "===== K3s / Kubectl installation complete in Server VM ====="