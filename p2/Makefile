# Configuration
VAGRANT_CMD = vagrant
PROVIDER = libvirt

# Colors
BOLD    = \033[1m
GREEN   = \033[32m
CYAN    = \033[36m
YELLOW  = \033[33m
EOC     = \033[0m

up:
	@printf "$(BOLD)$(CYAN)===== Starting VMs =====$(EOC)\n"
	@printf "$(GREEN)>>> Bringing up server VM (rchboukiS)...$(EOC)\n"
	@printf "$(YELLOW)Command:$(EOC) $(VAGRANT_CMD) up rchboukiS --provider=$(PROVIDER)\n"
	@$(VAGRANT_CMD) up rchboukiS --provider=$(PROVIDER)
	@printf "$(BOLD)$(CYAN)===== VM are up and running =====$(EOC)\n\n"

status:
	@printf "$(BOLD)$(CYAN)===== Checking VM Status =====$(EOC)\n"
	@printf "$(YELLOW)Command:$(EOC) $(VAGRANT_CMD) status\n"
	@$(VAGRANT_CMD) status

stop:
	@printf "$(BOLD)$(CYAN)===== Stopping all VMs =====$(EOC)\n"
	@printf "$(YELLOW)Command:$(EOC) $(VAGRANT_CMD) halt\n"
	@$(VAGRANT_CMD) halt

reload:
	@printf "$(BOLD)$(CYAN)===== Reloading VMs =====$(EOC)\n"
	@printf "$(YELLOW)Command:$(EOC) $(VAGRANT_CMD) reload\n"
	@$(VAGRANT_CMD) reload

destroy:
	@printf "$(BOLD)$(CYAN)===== Destroying VMs =====$(EOC)\n"
	@printf "$(YELLOW)Command:$(EOC) $(VAGRANT_CMD) destroy -f$(EOC)\n"
	@$(VAGRANT_CMD) destroy -f
	@printf "$(BOLD)$(CYAN)===== VM destroyed =====$(EOC)\n\n"

ssh-server:
	@printf "$(BOLD)$(CYAN)===== Connecting to Server VM (rchboukiS) =====$(EOC)\n"
	@printf "$(YELLOW)Command:$(EOC) $(VAGRANT_CMD) ssh rchboukiS\n"
	@$(VAGRANT_CMD) ssh rchboukiS
