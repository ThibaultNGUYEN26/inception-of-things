K3D_CMD = k3d
KUBECTL_CMD = kubectl
CLUSTER_NAME = my-cluster
ARGO_NS = argocd
DEV_NS = dev
GIT_FIE = /home/rchbouki/sgoinfre/inception_of_things/thibnguy

# Install all the necessary packages and tools
install:
	@sudo chmod +x ./scripts/install_tools.sh
	@./scripts/install_tools.sh


# Uninstall all packages and tools
uninstall:
	@$(K3D_CMD) cluster delete $(CLUSTER_NAME)
	@sudo chmod +x ./scripts/uninstall_tools.sh
	@./scripts/uninstall_tools.sh


# Create the k3d cluster
create:
	@$(K3D_CMD) cluster create $(CLUSTER_NAME) --api-port 6443 -p 8888:80@loadbalancer -p 32443:32443@loadbalancer --agents 2


# Create namespaces (idempotent)
namespace:
	@$(KUBECTL_CMD) create namespace $(ARGO_NS)
	@$(KUBECTL_CMD) create namespace $(DEV_NS)
	@$(KUBECTL_CMD) get namespaces


# Install ArgoCD
install-argocd:
	@$(KUBECTL_CMD) apply -n $(ARGO_NS) -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml


# Wait for all pods in argocd namespace to be Ready
check-pods:
	@echo "⏳ Waiting for all pods in namespace $(ARGO_NS) to be Ready..."
	@$(KUBECTL_CMD) wait --for=condition=Ready pod --all -n $(ARGO_NS) --timeout=180s
	@echo "✅ All pods in $(ARGO_NS) are Ready!"
	@$(KUBECTL_CMD) get pods -n $(ARGO_NS)


# Configure ingress, service and application
ingress:
	@$(KUBECTL_CMD) apply -f confs/ingress.yml -n argocd
	@$(KUBECTL_CMD) apply -f confs/app.yml -n argocd
	@$(KUBECTL_CMD) rollout restart deployment argocd-server -n argocd
# 	@$(KUBECTL_CMD) -n argocd patch secret argocd-secret -p '{"stringData":  {"admin.password": "iot", "admin.passwordMtime": "'$(date +%FT%T%Z)'"}}'
	@$(KUBECTL_CMD) get pods -n argocd
	@$(KUBECTL_CMD) get svc -n argocd argocd-server
# 	@$(KUBECTL_CMD) get ingress -n dev


# No port forwarding needed
ui:
	@$(KUBECTL_CMD)kubectl patch deployment argocd-server -n argocd --type='json' -p='[
	{
		"op": "add",
		"path": "/spec/template/spec/containers/0/args/-",
		"value": "--rootpath=/argocd"
	},
	{
		"op": "add",
		"path": "/spec/template/spec/containers/0/args/-",
		"value": "--insecure"
	}
	]'
	@$(KUBECTL_CMD) rollout restart deployment argocd-server -n argocd


# Run Port-Forwarding to login to argocd
port-forward:
	kubectl port-forward svc/argocd-server -n argocd 8443:443


# Access the deployed application
app:
	@curl http://localhost:8888/app

