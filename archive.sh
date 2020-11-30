#!/bin/bash

ARCH_DIRS="helm/ aarnet/ registry/ wget/ ocp-release/ olm/ bin/"
pushd /var/lib/import
tar -cvf - $ARCH_DIRS | split --bytes=10240m --suffix-length=3 --numeric-suffix - ../export/enterprise-k8s.tar.

