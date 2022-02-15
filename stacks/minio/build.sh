#!/bin/bash

# Load stack utils
. /usr/bin/stack-utils

# Implement build function
function build() {
  BIN_DIR="${TARNAME}/data/minio/bin"
  mkdir -p "${BIN_DIR}"
  curl -fsSL -o "${BIN_DIR}"/"${STACK_NAME}" https://dl.min.io/server/minio/release/linux-${OS_ARCH}/minio.${STACK_VERSION}
  chmod +x "${BIN_DIR}"/"${STACK_NAME}"

cat  << EOF > ${TARNAME}/data/minio/profile.d/minio.sh
export PATH="/opt/drycc/minio/bin:\$PATH"
EOF
}

# call build stack
build-stack "${1}"
