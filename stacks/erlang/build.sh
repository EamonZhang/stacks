#!/bin/bash

# Load stack utils
. /usr/bin/stack-utils

# Implement build function
function build() {
  generate-stack-path
  cat << EOF > "${META_DIR}"/dependencies
libssl1.1
libodbc1
libsctp1
libwxgtk3.0
EOF
  source-stack-path
  ./make.sh
  cp -rf /opt/drycc/erlang/* ${DATA_DIR}
}

# call build stack
build-stack "${1}"