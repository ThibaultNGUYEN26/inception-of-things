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
	@$(KUBECTL_CMD) get pods -n argocd
	@$(KUBECTL_CMD) get svc -n argocd argocd-server


# No port forwarding needed
ui:
	@$(KUBECTL_CMD) patch deployment argocd-server -n $(ARGO_NS) --type='json' -p='[{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--rootpath=/argocd"},{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--insecure"}]'
	@$(KUBECTL_CMD) rollout restart deployment argocd-server -n $(ARGO_NS)


# Get the default Argo CD admin password
get-admin-password:
	@$(KUBECTL_CMD) -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d; echo


# Set a new Argo CD admin password
# Usage: make set-admin-password PASSWORD=<newpassword>
set-admin-password:
	@if [ -z "$(PASSWORD)" ]; then echo "Usage: make set-admin-password PASSWORD=<newpassword>"; exit 1; fi
	@HASH=$$( if command -v htpasswd >/dev/null 2>&1; then \
				htpasswd -nbBC 10 "" "$(PASSWORD)" | tr -d ':\n' | sed -E 's/^\$\$2[by]/\$\$2a/'; \
			elif openssl passwd -help 2>&1 | grep -q bcrypt; then \
				openssl passwd -bcrypt "$(PASSWORD)" | sed -E 's/^\$\$2[by]/\$\$2a/'; \
			elif command -v docker >/dev/null 2>&1; then \
				docker run --rm -e ARGO_PWD="$(PASSWORD)" alpine:3 sh -lc 'apk add --no-cache apache2-utils >/dev/null && htpasswd -nbBC 10 "" "$$ARGO_PWD" | tr -d ":\n" | sed -E "s/^\$\$2[by]/\$\$2a/"'; \
			else \
				echo ""; \
			fi ); \
		if [ -z "$$HASH" ]; then echo "Cannot generate bcrypt hash. Install apache2-utils (htpasswd) or OpenSSL with bcrypt support."; exit 1; fi; \
		echo "Patching argocd-secret with new admin password..."; \
		mkdir -p "$(CURDIR)/.tmp"; \
		PATCH_FILE="$(CURDIR)/.tmp/argocd-secret-patch.json"; \
		/usr/bin/env printf '{"stringData":{"admin.password":"%s","admin.passwordMtime":"%s"}}' "$$HASH" "$$(/usr/bin/env date -u +%FT%TZ)" > "$$PATCH_FILE"; \
		$(KUBECTL_CMD) -n $(ARGO_NS) patch secret argocd-secret --type merge -p "$$(/usr/bin/env cat "$$PATCH_FILE")"; \
		rm -f "$$PATCH_FILE"; \
		echo "Restarting argocd-server..."; \
		$(KUBECTL_CMD) -n $(ARGO_NS) rollout restart deploy/argocd-server; \
		echo "Done. Login with username 'admin' and the new password."


# Access the deployed application
app:
	@curl http://localhost:8888/app
