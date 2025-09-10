#!/bin/bash
set -euo pipefail

echo -e "===== Installing all dependencies needed for k3d ====="

echo -e "\n===== Installing Docker... ====="
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker engine + CLI
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin


echo -e "\n===== Checking Docker version... ====="
echo "$(docker --version)"
echo "$(docker compose version)"

echo -e "\n===== Adding user to Docker group... ====="
sudo usermod -aG docker $USER

echo -e "\n===== Installing kubectl... ====="
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

echo -e "\n===== Checking kubectl version... ====="
echo "$(kubectl version --client)"

echo -e "\n===== Installing k3d... ====="
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
echo "$(k3d version)"

echo -e "\n✅ Installation complete!"
