#!/usr/bin/env bash

echo "Patching the ArgoCD Server service to use LoadBalancer..."
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

echo "Waiting for the LoadBalancer external IP..."
timeout=600
interval=5
elapsed=0

while true; do
    external_ip=$(kubectl get svc argocd-server -n argocd -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

    if [[ -n "$external_ip" ]]; then
        echo "External IP assigned: $external_ip"
        break
    fi

    if [[ $elapsed -ge $timeout ]]; then
        echo "Timeout reached! External IP not assigned."
        exit 1
    fi

    echo "Still waiting for external IP..."
    sleep $interval
    elapsed=$((elapsed + interval))
done

echo "ArgoCD is accessible at: http://$external_ip"
