#!/bin/bash

# Load stack utils
. /usr/bin/stack-utils

# Implement build function
function build() {
  generate-stack-path
  BIN_DIR="${DATA_DIR}"/bin
  mkdir -p "${BIN_DIR}"
  install-stack go "${GO_VERSION}"
  . init-stack
  curl -fsSL -o tmp.tar.gz https://github.com/buildpacks/pack/archive/refs/tags/v${STACK_VERSION}.tar.gz
  tar -xvzf tmp.tar.gz
  cd pack-${STACK_VERSION}
  # fix CVE-2022-28948
  go get -u ./...; go mod tidy; go mod vendor

  go build -o "${BIN_DIR}"/"${STACK_NAME}"
  cd ..
  rm -rf pack-${STACK_VERSION} tmp.tar.gz
}

# call build stack
build-stack "${1}"
