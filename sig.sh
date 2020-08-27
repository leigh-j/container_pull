#!/bin/bash
#see https://docs.openshift.com/container-platform/4.5/updating/updating-restricted-network-cluster.html#update-oc-configmap-signature-verification_updating-restricted-network-cluster
OCP_RELEASE_NUMBER=4.5.6
ARCH=x86_64
DIGEST="$(oc adm release info -a /etc/ansible/playbooks/all.json quay.io/openshift-release-dev/ocp-release:${OCP_RELEASE_NUMBER}-${ARCH} | sed -n 's/Pull From: .*@//p')"
DIGEST_ALGO="${DIGEST%%:*}"
DIGEST_ENCODED="${DIGEST#*:}"
SIGNATURE_BASE64=$(curl -s "https://mirror.openshift.com/pub/openshift-v4/signatures/openshift/release/${DIGEST_ALGO}=${DIGEST_ENCODED}/signature-1" | base64 -w0 && echo)


cat >checksum-${OCP_RELEASE_NUMBER}.yaml <<EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: release-image-${OCP_RELEASE_NUMBER}
  namespace: openshift-config-managed
  labels:
    release.openshift.io/verification-signatures: ""
binaryData:
  ${DIGEST_ALGO}-${DIGEST_ENCODED}: ${SIGNATURE_BASE64}
EOF


