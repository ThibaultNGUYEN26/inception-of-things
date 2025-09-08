#!/bin/bash
set -euo pipefail

# Colors
BOLD="\033[1m"
GREEN="\033[32m"
CYAN="\033[36m"
YELLOW="\033[33m"
EOC="\033[0m"

echo -e "${BOLD}${CYAN}===== Testing Applications via Ingress =====${EOC}"

SERVER_IP="192.168.56.110"

# Test App1
echo -e "\n${GREEN}>>> Testing app1.com...${EOC}"
echo -e "${YELLOW}Command:${EOC} curl -H \"Host: app1.com\" http://$SERVER_IP"
curl -H "Host: app1.com" http://$SERVER_IP
echo ""

# Test App2
echo -e "\n${GREEN}>>> Testing app2.com...${EOC}"
echo -e "${YELLOW}Command:${EOC} curl -H \"Host: app2.com\" http://$SERVER_IP"
curl -H "Host: app2.com" http://$SERVER_IP
echo ""

# Test App3
echo -e "\n${GREEN}>>> Testing app3.com...${EOC}"
echo -e "${YELLOW}Command:${EOC} curl -H \"Host: app3.com\" http://$SERVER_IP"
curl -H "Host: app3.com" http://$SERVER_IP
echo ""

echo -e "\n${BOLD}${CYAN}===== Application testing complete =====${EOC}\n"
