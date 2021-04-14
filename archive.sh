#!/bin/bash

PREF=ek8s
ARCH_DIRS=(helm aarnet wget registry)
#ARCH_DIRS="registry/ "
for source in ${ARCH_DIRS[@]}; do
  pushd /var/lib/import
  rm -Rf ../export/$PREF-$source.tar*
  tar -cf - $source | split --bytes=10240m --suffix-length=3 --numeric-suffix - ../export/$PREF-$source.tar.
  pushd /var/lib/export
  for part in $(find ./ -name "ek8s-$source.tar.*" | grep -v sha25); do
    sha256sum $part > $part.sha256sum
  done
done
#sha256sum $PREF.tar* > sha256.list

