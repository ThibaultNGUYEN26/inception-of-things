# Configuration
VAGRANT_CMD = vagrant
PROVIDER = libvirt

## Démarrer les VMs
up:
	sudo $(VAGRANT_CMD) up --provider=$(PROVIDER)

## Arrêter les VMs
halt:
	$(VAGRANT_CMD) halt

## Redémarrer les VMs
reload:
	$(VAGRANT_CMD) reload

## Détruire les VMs
destroy:
	$(VAGRANT_CMD) destroy -f

## Accès SSH au serveur
ssh-server:
	sudo chown $(whoami):$(whoami) .
	$(VAGRANT_CMD) ssh mutezaS

ssh-worker:
	sudo chown -R $(whoami):$(whoami) .
	$(VAGRANT_CMD) ssh hulefevrSW
##


## Reset le token du worker en cas de desync
reset-token:
	@echo "[INFO] 🔄 Récupération du nouveau token depuis le master..."
	vagrant ssh mutezaS -c "sudo cp /var/lib/rancher/k3s/server/node-token /vagrant_shared/node-token && sudo chmod 644 /vagrant_shared/node-token"

	@echo "[INFO] 🛑 Arrêt et nettoyage du worker..."
	vagrant ssh hulefevrSW -c "sudo systemctl stop k3s-agent || true"
	vagrant ssh hulefevrSW -c "sudo /usr/local/bin/k3s-killall.sh || true"
	vagrant ssh hulefevrSW -c "sudo rm -rf /etc/rancher/k3s /var/lib/rancher/k3s"

	@echo "[INFO] 📦 Réinstallation du worker avec le nouveau token..."
	vagrant ssh hulefevrSW -c 'export K3S_TOKEN=$$(cat /vagrant_shared/node-token) && \
		export K3S_URL="https://192.168.56.110:6443" && \
		curl -sfL https://get.k3s.io | K3S_TOKEN="$$K3S_TOKEN" K3S_URL="$$K3S_URL" sh -'

	@echo "[INFO] ✅ Vérification sur le master..."
	vagrant ssh mutezaS -c "sudo kubectl get nodes -o wide"


p1-prune:
# Nettoyer les VMs et les ressources associées
	$(VAGRANT_CMD) halt
	# sudo virsh destroy p1_mutezaS
	# sudo virsh destroy p1_hulefevrSW
	sudo virsh undefine p1_mutezaS --remove-all-storage
	sudo virsh undefine p1_hulefevrSW --remove-all-storage
	rm -rf .vagrant
