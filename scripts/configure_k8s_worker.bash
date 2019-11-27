#!/bin/bash

NODE_IP=$1

# Run the kubeadm join command from kubeadm init output generated on master
/vagrant/.scratch/join_k8s_cluster.bash

# Set Node IP and restart kubelet
echo KUBELET_EXTRA_ARGS=--node-ip=${NODE_IP} > /etc/default/kubelet
systemctl restart kubelet