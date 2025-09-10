#!/bin/bash
set -euo pipefail

# Colors
BOLD="\033[1m"
GREEN="\033[32m"
CYAN="\033[36m"
YELLOW="\033[33m"
EOC="\033[0m"

echo -e "${BOLD}${CYAN}===== K3s Cluster Health Check =====${EOC}"

# 1. Nodes
echo -e "\n${GREEN}>>> [1/4] Checking cluster nodes${EOC}"
echo -e "${YELLOW}Command:${EOC} kubectl get nodes"
kubectl get nodes
echo "-----------------------------------"

# 2. All states
echo -e "\n${GREEN}>>> [1/4] Checking all states are ready${EOC}"
echo -e "${YELLOW}Command:${EOC} kubectl get all"
kubectl get all
echo "-----------------------------------"

# 3. All Pods
echo -e "\n${GREEN}>>> [2/4] Checking all pods across namespaces${EOC}"
echo -e "${YELLOW}Command:${EOC} kubectl get pods -A"
kubectl get pods -A
echo "-----------------------------------"

# 4. All Services
echo -e "\n${GREEN}>>> [3/4] Checking services${EOC}"
echo -e "${YELLOW}Command:${EOC} kubectl get svc"
kubectl get svc
echo "-----------------------------------"

# 5. Ingress
echo -e "\n${GREEN}>>> [4/4] Checking ingress resources${EOC}"
echo -e "${YELLOW}Command:${EOC} kubectl get ingress"
kubectl get ingress
echo -e "\n${GREEN}>>> [4/4b] Detailed ingress information${EOC}"
echo -e "${YELLOW}Command:${EOC} kubectl describe ingress apps-ingress"
kubectl describe ingress apps-ingress
echo "-----------------------------------"

echo -e "\n${BOLD}${CYAN}===== Health Check Completed =====${EOC}\n"
