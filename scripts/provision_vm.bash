#!/bin/bash

apt-get update
apt-get upgrade -y
apt-get update && apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common

swapoff -a

/vagrant/scripts/install_docker.bash
/vagrant/scripts/install_k8s_tools.bash