#!/bin/bash
set -euo pipefail

echo "===== K3s Cluster Health Check ====="
echo

# 1. Nodes
echo ">>> Nodes:"
kubectl get nodes
echo "-----------------------------------"

# 2. All Pods
echo ">>> All Pods (All Namespaces):"
kubectl get pods -A
echo "-----------------------------------"

# 3. All Services
echo ">>> Services:"
kubectl get svc
echo "-----------------------------------"

# 4. Ingress
echo ">>> Ingress:"
kubectl get ingress
echo
kubectl describe ingress apps-ingress
echo "-----------------------------------"
