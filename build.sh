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
operator-sdk build --image-builder buildah ${OUTPUT_REGISTRY}/${OUTPUT_IMAGE}
sleep 3600