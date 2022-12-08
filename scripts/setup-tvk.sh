#!/bin/bash

sudo snap install helm --classic

helm repo add triliovault-operator http://charts.k8strilio.net/trilio-stable/k8s-triliovault-operator 2>/dev/null
helm repo update 2>/dev/null

sleep 1

helm install tvm triliovault-operator/k8s-triliovault-operator 2>/dev/null
helm list

echo "Installation of TVK will be a few minutes..."

sleep 420
kubectl --namespace=default get deployments -l "release=triliovault-operator"
