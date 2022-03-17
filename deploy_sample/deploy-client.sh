#!/bin/bash

kubectl run --image curlimages/curl client -- sleep 3600

# access to container
# kubectl exec -it client -- sh

