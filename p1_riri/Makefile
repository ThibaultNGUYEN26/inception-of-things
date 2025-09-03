# Configuration
VAGRANT_CMD = vagrant
PROVIDER = libvirt

## Démarrer les VMs
up:
	$(VAGRANT_CMD) up rchboukiS --provider=$(PROVIDER)
	$(VAGRANT_CMD) up rchboukiSW --provider=$(PROVIDER)

status:
	$(VAGRANT_CMD) status

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
	$(VAGRANT_CMD) ssh rchboukiS

ssh-worker:
	$(VAGRANT_CMD) ssh rchboukiSW
