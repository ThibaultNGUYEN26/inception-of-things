#!/bin/bash
set -euo pipefail

# Colors
BOLD="\033[1m"
GREEN="\033[32m"
CYAN="\033[36m"
YELLOW="\033[33m"
EOC="\033[0m"

echo -e "${BOLD}${CYAN}===== Applying Applications =====${EOC}"

cd /home/vagrant/p2/confs

# App1
echo -e "\n${GREEN}>>> Applying App1${EOC}"
echo -e "${YELLOW}Command:${EOC} kubectl apply -f app1/"
kubectl apply -f app1/
echo "-----------------------------------"

# App2
echo -e "\n${GREEN}>>> Applying App2${EOC}"
echo -e "${YELLOW}Command:${EOC} kubectl apply -f app2/"
kubectl apply -f app2/
echo "-----------------------------------"

# App3 (via Kustomize to include static files)
echo -e "\n${GREEN}>>> Applying App3${EOC}"
echo -e "${YELLOW}Command:${EOC} kubectl apply -k app3/"
kubectl apply -k app3/
echo "-----------------------------------"

# Ingress
echo -e "\n${GREEN}>>> Applying Ingress${EOC}"
echo -e "${YELLOW}Command:${EOC} kubectl apply -f ingress.yml"
kubectl apply -f ingress.yml
echo "-----------------------------------"

echo -e "\n${BOLD}${CYAN}===== All applications and ingress have been applied =====${EOC}\n"
