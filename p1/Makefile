# Configuration
VAGRANT_CMD = vagrant
PROVIDER = libvirt

up:
	$(VAGRANT_CMD) up rchboukiS --provider=$(PROVIDER)
	$(VAGRANT_CMD) up thibnguySW --provider=$(PROVIDER)

status:
	$(VAGRANT_CMD) status

stop:
	$(VAGRANT_CMD) halt

reload:
	$(VAGRANT_CMD) reload

destroy:
	$(VAGRANT_CMD) destroy -f

ssh-server:
	$(VAGRANT_CMD) ssh rchboukiS

ssh-worker:
	$(VAGRANT_CMD) ssh thibnguySW


# Put comments in Makefile
# check 644 in k3s installation
# ip of worker in 'kubectl get nodes -o wide (in server)' doesnt show 111
# investigate why kubectl get nodes doesn't work in worker
# maybe create .env (optional) -> # config.vm.synced_folder "/home/${USER}/iot/p1", "/home/vagrant/p1",
# clean scripts and maybe display commands
