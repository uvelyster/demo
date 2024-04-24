#!/bin/bash

# Install nginx ingress controller 
kubectl apply -f \
https://raw.githubusercontent.com/kubernetes/ingress-nginx/\
controller-v1.1.0/deploy/static/provider/cloud/deploy.yaml

# Verify ingress controller 
kubectl get pod -n ingress-nginx

#---------------------------

# Install MetalLB 
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.14.4/config/manifests/metallb-native.yaml

# metallb_pool_config.yaml
cat << EOF > metallb_pool_config.yaml
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: first-pool
  namespace: metallb-system
spec:
  addresses:
  - 172.16.0.210-172.16.0.220
---
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: example
  namespace: metallb-system
spec:
  ipAddressPools:
  - first-pool
EOF


kubectl apply -f metallb_pool_config.yaml

kubectl get svc -n ingress-nginx 



