#!/bin/bash
set -euo pipefail

echo "===== Installing K3s in Agent Mode on the worker VM ====="

# --- Read server IP and node token from shared folder ---
SHARED_FOLDER="/home/vagrant/p1"
SERVER_IP="192.168.56.110"
NODE_TOKEN=$(< "$SHARED_FOLDER/tokens/node")

echo ">>> Using Node Token from $NODE_TOKEN"
echo ">>> Connecting to K3s server at $SERVER_IP"

echo ">>> Installing K3s agent (non-blocking)..."
curl -sfL https://get.k3s.io | \
    K3S_URL="https://$SERVER_IP:6443" \
    K3S_TOKEN="$NODE_TOKEN" \
    K3S_AGENT_SKIP_START=true sh -

echo ">>> Starting K3s agent service..."
sudo systemctl enable k3s-agent
sudo systemctl start k3s-agent

echo -e "===== K3s / Kubectl installation complete on Worker VM ====="