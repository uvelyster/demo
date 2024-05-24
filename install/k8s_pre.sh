#!/bin/bash

modprobe br_netfilter
modprobe overlay

# lsmod | grep br_netfilter

cat <<EOF > /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF
sysctl --system

setenforce 0
sed -i  s/SELINUX=enforcing/SELINUX=permissive/ /etc/selinux/config

swapoff -a 
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

cat /etc/fstab
swapon -s 

yum install wget -y
wget https://download.docker.com/linux/centos/docker-ce.repo -O /etc/yum.repos.d/docker-ce.repo

yum install -y containerd.io

containerd config default > /etc/containerd/config.toml
systemctl start containerd && systemctl enable containerd
sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
sed -i \
 's,config_path = \"\",config_path = \"/etc/containerd/certs.d\",g' \
 /etc/containerd/config.toml

systemctl restart containerd 

cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.30/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.30/rpm/repodata/repomd.xml.key
exclude=kubelet kubeadm kubectl cri-tools kubernetes-cni
EOF

yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
systemctl enable kubelet && systemctl start kubelet

