#!/bin/bash
set -euo pipefail

# Colors
BOLD="\033[1m"
GREEN="\033[32m"
CYAN="\033[36m"
YELLOW="\033[33m"
EOC="\033[0m"

echo -e "${BOLD}${CYAN}===== Installing K3s in Agent Mode on the Worker VM =====${EOC}"

# --- Read server IP and node token from shared folder ---
SHARED_FOLDER="/home/vagrant/p1"
SERVER_IP="192.168.56.110"
WORKER_IP="192.168.56.111"
K3S_TOKEN=$(< "$SHARED_FOLDER/confs/node")

echo -e "\n${GREEN}>>> Using Node Token from:${EOC} ${YELLOW}$SHARED_FOLDER/confs/node${EOC}"
echo -e "${GREEN}>>> Connecting to K3s server at:${EOC} ${YELLOW}$SERVER_IP${EOC}"

# --- Install K3s Agent ---
echo -e "\n${GREEN}>>> Installing K3s agent (non-blocking)...${EOC}"
echo -e "${YELLOW}Command:${EOC} curl -sfL https://get.k3s.io | K3S_URL=https://$SERVER_IP:6443 K3S_TOKEN=*** sh -s - agent --node-ip \"$WORKER_IP\""

curl -sfL https://get.k3s.io | K3S_URL=https://$SERVER_IP:6443 K3S_TOKEN=$K3S_TOKEN sh -s - \
    agent --node-ip "$WORKER_IP"

# --- Start Agent Service ---
echo -e "\n${GREEN}>>> Starting K3s agent service...${EOC}"
echo -e "${YELLOW}Command:${EOC} sudo systemctl enable k3s-agent && sudo systemctl start k3s-agent"

sudo systemctl enable k3s-agent
sudo systemctl start k3s-agent

echo -e "\n${BOLD}${CYAN}===== K3s / Kubectl installation complete on Worker VM =====${EOC}\n"
