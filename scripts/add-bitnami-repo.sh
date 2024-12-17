#!/usr/bin/env bash

echo "Adding Bitnami Helm repository using Helm CLI..."
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

echo "Available Helm repositories:"
helm repo list

echo "Script completed successfully."
