#!/bin/bash
echo "[INFO] Installing K3s controller on mutezaS..."

curl -sfL https://get.k3s.io | sh -

# Rendre le token lisible
sudo cp /var/lib/rancher/k3s/server/node-token /vagrant_shared/node-token
sudo chmod 644 /vagrant_shared/node-token

echo "[INFO] node-token is ready."
