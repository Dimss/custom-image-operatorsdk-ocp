#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace

echo "---> Starting Operator-SKD Ansible build ..."
SRC_DIR=$(pwd)/src


# Clone the source code
git clone ${SOURCE_URI} ${SRC_DIR}
cd ${SRC_DIR}
# Build Ansible Operator image
operator-sdk build --image-builder buildah ${OUTPUT_REGISTRY}/${OUTPUT_IMAGE}
# buildah requires a slight modification to the push secret provided by the service
# account in order to use it for pushing the image
# https://docs.openshift.com/container-platform/4.3/builds/custom-builds-buildah.html
cp /var/run/secrets/openshift.io/push/.dockercfg /tmp
(echo "{ \"auths\": " ; cat /var/run/secrets/openshift.io/push/.dockercfg ; echo "}") > /tmp/.dockercfg

buildah  push --tls-verify=false --authfile /tmp/.dockercfg ${OUTPUT_REGISTRY}/${OUTPUT_IMAGE}