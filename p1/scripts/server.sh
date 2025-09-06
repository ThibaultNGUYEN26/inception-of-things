#!/bin/bash
set -euo pipefail

# Colors
BOLD="\033[1m"
GREEN="\033[32m"
CYAN="\033[36m"
YELLOW="\033[33m"
EOC="\033[0m"

echo -e "${BOLD}${CYAN}===== Installing K3s in Controller Mode on the Server VM =====${EOC}"

# --- Install dependencies ---
echo -e "\n${GREEN}>>> Installing make...${EOC}"
echo -e "${YELLOW}Command:${EOC} sudo apt-get update && sudo apt-get install -y make"
sudo apt-get update && sudo apt-get install -y make

PRIVATE_IP="192.168.56.110"
SHARED_FOLDER="/home/vagrant/p1"

# --- Install K3s ---
echo -e "\n${GREEN}>>> Installing K3s...${EOC}"
echo -e "${YELLOW}Command:${EOC} curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE=\"644\" sh -s - server --node-ip \"$PRIVATE_IP\" --advertise-address \"$PRIVATE_IP\" --tls-san \"$PRIVATE_IP\""

# Mode 644 activates the controller mode -> ownership allowed to read and write
curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" sh -s - \
    server --node-ip "$PRIVATE_IP" \
    --advertise-address "$PRIVATE_IP" \
    --tls-san "$PRIVATE_IP"

# --- Save node token to shared folder ---
echo -e "\n${GREEN}>>> Saving node token to shared folder...${EOC}"
echo -e "${YELLOW}Command:${EOC} sudo cat /var/lib/rancher/k3s/server/node-token > $SHARED_FOLDER/confs/node"

NODE_TOKEN=$(sudo cat /var/lib/rancher/k3s/server/node-token)
echo "$NODE_TOKEN" > "$SHARED_FOLDER/confs/node"

echo -e "\n${BOLD}${CYAN}===== K3s / Kubectl installation complete in Server VM =====${EOC}\n"
