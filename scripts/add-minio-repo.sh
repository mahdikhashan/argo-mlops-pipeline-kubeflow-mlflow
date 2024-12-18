#!/usr/bin/env bash

echo "Adding Minio Helm repository using Helm CLI..."
helm repo add minio https://charts.min.io/
helm repo update

echo "Available Helm repositories:"
helm repo list

echo "Script completed successfully."
