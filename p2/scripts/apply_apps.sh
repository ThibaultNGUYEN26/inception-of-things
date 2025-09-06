#!/bin/bash
set -euo pipefail

echo "===== Applying applications... ====="
cd /home/vagrant/p2/confs
kubectl apply -f app1/
kubectl apply -f app2/
kubectl apply -f app3/
kubectl apply -f ingress.yml

echo "===== All applications and ingress have been applied ====="