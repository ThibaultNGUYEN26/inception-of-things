#!/bin/bash
set -euo pipefail

echo -e "===== Uninstalling Docker, kubectl, and k3d =====\n"

# Uninstall Docker
sudo apt-get purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin || true
sudo rm -rf /var/lib/docker /var/lib/containerd

# Uninstall kubectl
sudo rm -f /usr/local/bin/kubectl

# Uninstall k3d
sudo rm -f /usr/local/bin/k3d

# Cleanup
rm -rf ~/.kube ~/.config/k3d

echo -e "\n✅ Uninstallation complete!"
