#!/bin/bash

# install on rocky
sudo curl -o /etc/yum.repos.d/docker-ce.repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce
