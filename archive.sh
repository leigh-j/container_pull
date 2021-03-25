#!/bin/bash

PREF=ek8s
#ARCH_DIRS="registry/ helm/ aarnet/ wget/ ocp-release/ olm/ bin/"
ARCH_DIRS="registry/ "
pushd /var/lib/import
rm -Rf ../export/*
tar -cf - $ARCH_DIRS | split --bytes=10240m --suffix-length=3 --numeric-suffix - ../export/$PREF.tar.
pushd /var/lib/export
sha256sum $PREF.tar* > sha256.list

