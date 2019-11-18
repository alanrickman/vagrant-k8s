#!/bin/bash

POD_NETWORK_CIDR=$1
MASTER_IP_ADDR=$2

# Bootstrap the cluster
kubeadm init --pod-network-cidr ${POD_NETWORK_CIDR} --apiserver-advertise-address ${MASTER_IP_ADDR} | tee /var/log/kubeadm-init.log

# Setup kubectl for vagrant and root user
if [ -d /vagrant/.kube ]; then
  rm -rf /vagrant/.kube
fi
mkdir -p /home/vagrant/.kube
mkdir -p /vagrant/.kube
mkdir -p /root/.kube
cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
cp -i /etc/kubernetes/admin.conf /root/.kube/config
cp -i /etc/kubernetes/admin.conf /vagrant/.kube/config
chown vagrant:vagrant /home/vagrant/.kube/config

# Install Calico as per https://docs.projectcalico.org/v3.10/getting-started/kubernetes/installation/calico
curl https://docs.projectcalico.org/v3.10/manifests/calico.yaml -O --silent
sed -i -e "s?192.168.0.0/16?${POD_NETWORK_CIDR}?g" calico.yaml
kubectl apply -f calico.yaml && rm -f calico.yaml

# Get command from kubeadm output for joining workers to cluster
cat /var/log/kubeadm-init.log | grep "kubeadm join" -A1 > /vagrant/join_k8s_cluster.bash
chmod +x /vagrant/join_k8s_cluster.bash