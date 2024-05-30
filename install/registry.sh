#!/bin/bash

mkdir /auth 

openssl req -newkey rsa:4096 -nodes -sha256 -x509 \
 -days 365 -keyout /auth/myregistry.com.key -out /auth/myregistry.com.crt \
 -subj '/CN=myregistry.com' \
 -addext "subjectAltName = DNS:myregistry.com"

mkdir -p /etc/docker/certs.d/myregistry.com

cp /auth/myregistry.com.crt /etc/docker/certs.d/myregistry.com/ca.crt

docker run -d -p 443:443 \
 --restart=always --name registry \
 -v /image-data:/var/lib/registry \
 -v /auth:/certs \
 -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/myregistry.com.crt \
 -e REGISTRY_HTTP_TLS_KEY=/certs/myregistry.com.key \
 -e REGISTRY_HTTP_ADDR=0.0.0.0:443 \
quay.io/uvelyster/registry:new
