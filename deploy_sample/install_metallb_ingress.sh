#!/bin/bash

# Install nginx ingress controller 
kubectl apply -f \
https://raw.githubusercontent.com/kubernetes/ingress-nginx/\
controller-v1.1.0/deploy/static/provider/cloud/deploy.yaml

# Verify ingress controller 
kubectl get pod -n ingress-nginx

#---------------------------

# Install MetalLB 
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.10.2/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.10.2/manifests/metallb.yaml

# Config MetalLB Pool 
cat << EOF > metallb_pool_config.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      addresses:
      - 172.16.0.210-172.16.0.220
EOF

kubectl apply -f metallb_pool_config.yaml

kubectl get svc -n ingress-nginx 



