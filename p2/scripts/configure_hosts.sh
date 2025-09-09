#!/bin/bash
set -euo pipefail

# Configure /etc/hosts so app domains resolve to the K3s VM IP
IP="192.168.56.110"
DOMAINS=(app1.com app2.com app3.com)
LINE="$IP ${DOMAINS[*]}"
PATTERN='\b(app1\.com|app2\.com|app3\.com)\b'

if [[ $(id -u) -ne 0 ]]; then
  SUDO="sudo"
else
  SUDO=""
fi

echo "Configuring /etc/hosts for: ${DOMAINS[*]} -> $IP"

# Remove any existing lines mentioning our domains to avoid duplicates/wrong IPs
if grep -qE "$PATTERN" /etc/hosts; then
  echo "Existing entries found. Updating..."
  $SUDO sed -i.bak -E "/$PATTERN/d" /etc/hosts
fi

echo "$LINE" | $SUDO tee -a /etc/hosts >/dev/null
echo "Added: $LINE"

