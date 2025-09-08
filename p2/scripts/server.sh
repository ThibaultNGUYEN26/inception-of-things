#!/bin/bash
set -euo pipefail

# Colors
BOLD="\033[1m"
GREEN="\033[32m"
CYAN="\033[36m"
YELLOW="\033[33m"
EOC="\033[0m"

echo -e "${BOLD}${CYAN}===== Installing K3s in Controller Mode on the Server VM =====${EOC}"

PRIVATE_IP="192.168.56.110"

# --- Install K3s ---
echo -e "\n${GREEN}>>> Installing K3s...${EOC}"
echo -e "${YELLOW}Command:${EOC} curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE=\"644\" sh -s - server --node-ip \"$PRIVATE_IP\" --advertise-address \"$PRIVATE_IP\" --tls-san \"$PRIVATE_IP\""

curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" sh -s - \
    server --node-ip "$PRIVATE_IP" \
    --advertise-address "$PRIVATE_IP" \
    --tls-san "$PRIVATE_IP"

echo -e "\n${BOLD}${CYAN}===== K3s / Kubectl installation complete in Server VM =====${EOC}\n"
