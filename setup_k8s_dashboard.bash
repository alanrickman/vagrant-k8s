#!/bin/bash

export KUBECONFIG=.kube/config

# Install unsecured dashboard
kubectl apply -f kubernetes-dashboard.yaml --request-timeout 2m --kubeconfig=.kube/config

# Grant permissions
kubectl create clusterrolebinding kubernetes-dashboard --clusterrole=cluster-admin --serviceaccount=kube-system:kubernetes-dashboard
