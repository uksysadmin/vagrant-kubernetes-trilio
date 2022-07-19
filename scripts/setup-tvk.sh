#!/bin/bash

sudo snap install helm --classic

helm repo add triliovault-operator http://charts.k8strilio.net/trilio-stable/k8s-triliovault-operator 2>/dev/null
helm repo update 2>/dev/null

sleep 1

helm install tvm triliovault-operator/k8s-triliovault-operator 2>/dev/null
helm list

sleep 1

kubectl --namespace=default get deployments -l "release=triliovault-operator"
sleep 120
kubectl --namespace=default get deployments -l "release=triliovault-operator"
