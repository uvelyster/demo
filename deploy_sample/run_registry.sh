#!/bin/bash

docker run -d -p 443:443 \
 --restart=always --name registry \
 -v /image-data:/var/lib/registry \
 -v /auth:/certs \
 -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/myregistry.com.crt \
 -e REGISTRY_HTTP_TLS_KEY=/certs/myregistry.com.key \
 -e REGISTRY_HTTP_ADDR=0.0.0.0:443 \
 registry
