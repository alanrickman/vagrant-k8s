# vagrant-k8s

This project provides a multi-node Kubernetes cluster using Vagrant and VirtualBox.

## Get up and running

* `vagrant up`
* `export KUBECONFIG=./kube.config`
* `kubectl get nodes -o wide`

## Kubernetes dashboard

Install and run the dashboard with the following commands:

* `./setup_k8s_dashboard.bash`
* `./run_k8s_dashboard.bash`
* Go to: [dashboard](http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/login)

## Helm

Install and run Helm with the following commands:

* `./setup_helm.bash`
