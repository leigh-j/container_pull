#!/bin/bash
podman run --name mirror-registry -p 7000:5000 \
     -v /var/lib/data/registry/data:/var/lib/registry:z \
     -v /var/lib/data/registry/auth:/auth:z \
     -e "REGISTRY_AUTH=htpasswd" \
     -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
     -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \
     -v /var/lib/data/registry/certs:/certs:z \
     -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/registry.home.crt \
     -e REGISTRY_HTTP_TLS_KEY=/certs/registry.home.key \
     -d docker.io/library/registry:2
