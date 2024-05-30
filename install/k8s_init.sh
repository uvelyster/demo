#!/bin/bash

CALICO_VERSION=v3.26.1

# initialize controlplane
# kubeadm init --pod-network-cidr=192.168.0.0/16 --apiserver-advertise-address=172.16.0.201

# Install CLI 
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl

mkdir ~/.kube
scp controlplane:/etc/kubernetes/admin.conf ~/.kube/config

# Install ProjectCalico
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/$CALICO_VERSION/manifests/tigera-operator.yaml
curl -o calico-cr-quay.yaml https://raw.githubusercontent.com/projectcalico/calico/$CALICO_VERSION/manifests/custom-resources.yaml
sed -i -r -e "/Configures Calico networking./a\  registry: quay.io" calico-cr-quay.yaml
kubectl create -f calico-cr-quay.yaml

# Create Namespace demo
kubectl create ns demo
kubectl config set-context --current --namespace demo

