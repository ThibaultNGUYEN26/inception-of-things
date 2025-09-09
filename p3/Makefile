K3D_CMD      = k3d
KUBECTL_CMD  = kubectl
CLUSTER_NAME = my-cluster
ARGO_NS      = argocd
DEV_NS       = dev

# Install all the necessary packages and tools
install:
	@sudo chmod +x ./scripts/install_tools.sh
	@./scripts/install_tools.sh


# Uninstall all packages and tools
uninstall:
	@sudo chmod +x ./scripts/uninstall_tools.sh
	@./scripts/uninstall_tools.sh


# Create the k3d cluster
create:
	@$(K3D_CMD) cluster create $(CLUSTER_NAME) --api-port 6443 -p 8888:80@loadbalancer -p 32443:32443@loadbalancer --agents 2


# Create namespaces (idempotent)
namespace:
	@$(KUBECTL_CMD) create namespace $(ARGO_NS) --dry-run=client -o yaml | $(KUBECTL_CMD) apply -f -
	@$(KUBECTL_CMD) create namespace $(DEV_NS) --dry-run=client -o yaml | $(KUBECTL_CMD) apply -f -
	@$(KUBECTL_CMD) get namespaces


# Install ArgoCD
install_argocd:
	@$(KUBECTL_CMD) apply -n $(ARGO_NS) -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml


# Wait for all pods in argocd namespace to be Ready
check_pods:
	@echo "⏳ Waiting for all pods in namespace $(ARGO_NS) to be Ready..."
	@$(KUBECTL_CMD) wait --for=condition=Ready pod --all -n $(ARGO_NS) --timeout=180s
	@echo "✅ All pods in $(ARGO_NS) are Ready!"
	@$(KUBECTL_CMD) get pods -n $(ARGO_NS)


# Configure ingress and application
confs:
	@$(KUBECTL_CMD) apply -f confs/ingress.yml -n argocd
	@$(KUBECTL_CMD) apply -f confs/app.yml -n argocd


