CURRENT_DIR:=$(shell pwd)

DO_ACCESS_TOKEN:=$(shell cat dotoken)

DO_CLUSTER_NAME:=kubeflow
DO_CLUSTER_SIZE:=s-2vcpu-4gb
DO_CLUSTER_NODE_COUNT:=2

ARGOCD_PORT:=8080
ARGOCD_PORTFORWARD_LOG:=portforward.log
ARGOCD_PID:=argo-cd-pid.txt

default: debug init-doctl do-create-cluster do-cluster-config do-cluster-get-nodes

debug:
	echo CURRENT_DIR is ${CURRENT_DIR}
	echo Using shell: $$SHELL
	echo Digital Ocean Token ${DO_ACCESS_TOKEN}

init-doctl:
	doctl auth init --access-token ${DO_ACCESS_TOKEN}

.PHONY: debug
do-create-cluster: debug
	doctl kubernetes cluster create kubeflow --count=2 --size=s-4vcpu-8gb-intel

do-cluster-config: debug
	doctl kubernetes cluster kubeconfig save kubeflow

do-cluster-get-nodes: debug
	kubectl --kubeconfig=/Users/mahdikhashan/.kube/config get nodes

.PHONY: install-argo
.install-argo:
	kubectl create namespace argocd
	@while ! kubectl get namespace argocd &>/dev/null; do \
      		echo "Waiting for namespace 'argocd' to be created..."; \
            sleep 1; \
    done
	kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
	kubectl wait --for=condition=ready pod --all -n argocd --timeout=600s
	bash ./scripts/patch_argocd_loadbalancer.sh
	kubectl apply -f ./setup/argocd-cm.yaml
	kubectl apply -f ./setup/argocd-secret.yaml
	kubectl apply -f ./setup/argocd-repositories.yaml

.apply-argo-config:
	kubectl apply -f ./setup/argocd-cm.yaml
	kubectl apply -f ./setup/argocd-secret.yaml
	kubectl apply -f ./setup/argocd-repositories.yaml

.stop-and-remove-argo:
	kubectl delete applications --all -n argocd --ignore-not-found
	kubectl delete namespace argocd --force --grace-period=0 --ignore-not-found
	kubectl delete all -l app.kubernetes.io/part-of=argocd --all-namespaces --ignore-not-found

.clean-up-default-namespace:
	kubectl get all --namespace=default
	kubectl delete namespace default --force --grace-period=0 --ignore-not-found

.remove-load-balancers:
	doctl compute lb list
	#doctl compute load-balancer remove-droplets

.PHONY: install-base-argo-app
.install-base-argo-app:
	kubectl apply -f apps/base/base.yaml

.PHONY: get-grafana-password
.get-grafana-password:
	kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

.PHONY: portforward-app
.portforward-app:
	kubectl port-forward svc/istio-ingressgateway -n istio-system 8080:80
