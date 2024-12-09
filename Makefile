#!make
-include .env
export

$(if $(DIGITALOCEAN_TOKEN),,$(error Must set DIGITALOCEAN_TOKEN))

# Variables
BACKEND_DIR = backend_app
FRONTEND_DIR = frontend
REGISTRY_NAME = registry.digitalocean.com/template
BACKEND_REPO = template
FRONTEND_REPO = frontend_app
CELERY_REPO = celery_worker
ENV = prod

deploy:
	kubectl scale deployment hubble-relay --replicas=0 -n kube-system
	kubectl scale deployment hubble-ui --replicas=0 -n kube-system
	envsubst < k8s/$(ENV)/configs/backend-template.yml > k8s/$(ENV)/configs/backend.yml
	rm k8s/$(ENV)/configs/backend-template.yml

	envsubst < k8s/$(ENV)/grafana/grafana-agent-config-template.yml > k8s/$(ENV)/grafana/grafana-agent-config.yml
	rm k8s/$(ENV)/grafana/grafana-agent-config-template.yml

	kubectl apply -f k8s/$(ENV)/namespace.yml
	kubectl apply -f k8s/$(ENV)/grafana/namespace.yml
	kubectl apply -f k8s/$(ENV)/grafana/grafana-agent-service-account.yml
	
	kubectl apply -f k8s/$(ENV)/configs/configmap.yml
	kubectl apply -f k8s/$(ENV)/configs/backend.yml
	kubectl apply -f k8s/$(ENV)/cert-manager.yml
	kubectl apply -f k8s/$(ENV)/issuer.yml
	sed -i 's|<DO_TOKEN>|$(DIGITALOCEAN_TOKEN)|' k8s/$(ENV)/externaldns.yml
	sed -i 's|<IMAGE>|$(REGISTRY_NAME)/$(CELERY_REPO):$(shell git rev-parse --short HEAD)|' k8s/$(ENV)/celery/deployment.yml
	sed -i 's|<IMAGE>|$(REGISTRY_NAME)/$(FRONTEND_REPO):$(shell git rev-parse --short HEAD)|' k8s/$(ENV)/frontend/deployment.yml
	sed -i 's|<IMAGE>|$(REGISTRY_NAME)/$(BACKEND_REPO):$(shell git rev-parse --short HEAD)|' k8s/$(ENV)/backend_app/deployment.yml
	kubectl apply --recursive -f k8s/$(ENV)/
	kubectl apply -f k8s/$(ENV)/ingress.yml

