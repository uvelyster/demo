#!/bin/bash

# install on rocky
sudo curl -o /etc/yum.repos.d/docker-ce.repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce 
sudo systemctl start docker
sudo systemctl enable docker
