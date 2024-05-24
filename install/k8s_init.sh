#!/bin/bash

# initialize
# kubeadm init --pod-network-cidr=192.168.0.0/16 --apiserver-advertise-address=controlplane

# CLI
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl

mkdir ~/.kube
scp controlplane:/etc/kubernetes/admin.conf ~/.kube/config

# Calico
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/tigera-operator.yaml
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/custom-resources.yaml

# namespace
kubectl create ns demo
kubectl config set-context --current --namespace demo

