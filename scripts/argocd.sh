#!/usr/bin/env bash

apply()
{
  kubectl apply -n $1 -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

  echo "Waiting for deployments to be ready in ${1}..."
  kubectl wait --for=condition=available deployment --all -n ${1} --timeout=600s

  echo "Waiting for pods to be in the 'Running' state..."
  kubectl wait --for=condition=ready pod --all -n ${1} --timeout=600s

  echo "All pods are running!"
  kubectl get pods -n ${1}
}

portforward()
{
  kubectl port-forward svc/argocd-server -n $1 $2:443 > $3 2>&1 & echo $$! > $4;

  while ! nc -z localhost ${2}; do \
  		echo "Waiting for port-forward to be ready..."; \
  		sleep 1; \
  done

  echo "Port-forward established on port ${2}."
}

ui_admin_password()
{
  kubectl -n $1 get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
}
