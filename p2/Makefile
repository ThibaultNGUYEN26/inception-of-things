# Configuration
VAGRANT_CMD = vagrant
PROVIDER = libvirt

up:
	$(VAGRANT_CMD) up rchboukiS --provider=$(PROVIDER)

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


# clean scripts and maybe display commands
# add curls in a script to show apps