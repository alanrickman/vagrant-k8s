#!/bin/bash

NODE_IP=$1

# Run the kubeadm join command from kubeadm init output generated on master
/vagrant/join_k8s_cluster.bash
echo KUBELET_EXTRA_ARGS=--node-ip=${NODE_IP} > /etc/default/kubelet