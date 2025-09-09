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

# Helper: test via DNS only if the hostname resolves to SERVER_IP
dns_resolves() {
    local host="$1"
    local ip
    ip=$(getent hosts "$host" 2>/dev/null | awk '{print $1}' | head -n1 || true)
    [[ "$ip" == "$SERVER_IP" ]]
}

test_via_dns() {
    local host="$1"
    echo -e "\n${GREEN}>>> Testing ${host} via DNS...${EOC}"
    if dns_resolves "$host"; then
        echo -e "${YELLOW}Command:${EOC} curl http://${host}"
        curl "http://${host}"
    else
        echo -e "${YELLOW}Skipping:${EOC} ${host} does not resolve to ${SERVER_IP}."
        echo -e "Add to /etc/hosts: 'echo \"${SERVER_IP} ${host}\" | sudo tee -a /etc/hosts'"
    fi
    echo ""
}

# Test App1
echo -e "\n${GREEN}>>> Testing app1.com...${EOC}"
echo -e "${YELLOW}Command:${EOC} curl -H \"Host: app1.com\" http://$SERVER_IP"
curl -H "Host: app1.com" http://$SERVER_IP
test_via_dns "app1.com"

# Test App2
echo -e "\n${GREEN}>>> Testing app2.com...${EOC}"
echo -e "${YELLOW}Command:${EOC} curl -H \"Host: app2.com\" http://$SERVER_IP"
curl -H "Host: app2.com" http://$SERVER_IP
test_via_dns "app2.com"

# Test App3
echo -e "\n${GREEN}>>> Testing app3.com...${EOC}"
echo -e "${YELLOW}Command:${EOC} curl -H \"Host: app3.com\" http://$SERVER_IP"
curl -H "Host: app3.com" http://$SERVER_IP
test_via_dns "app3.com"

echo -e "\n${BOLD}${CYAN}===== Application testing complete =====${EOC}\n"
