set -eux
tag=$(echo "${STACK_VERSION}" | awk -F "." '{print "jdk-"$1"+"$2}')
curl -fsSL -o java.tar.gz https://github.com/openjdk/jdk/archive/refs/tags/${tag}.tar.gz
tar -xvzf java.tar.gz
cd jdk-jdk-*-*
install-packages \
  openjdk-17-jdk \
  libx11-dev \
  libxext-dev \
  libxrender-dev \
  libxrandr-dev \
  libxtst-dev \
  libxt-dev \
  libcups2-dev \
  libfontconfig1-dev \
  libasound2-dev \
  zip

version_build=$(echo "${STACK_VERSION}" | awk -F "." '{print $2}')

bash configure \
  --with-jvm-variants=server \
  --enable-unlimited-crypto \
  --with-version-build="${version_build}" \
  --with-version-pre="drycc" \
  --with-version-opt="" \
  --with-vendor-version-string="$(date '+%Y%m%d%H%M%S')" \
  -with-native-debug-symbols=external \
  --disable-warnings-as-errors
make
cp -rf build/linux-*-server-release/jdk/* "${DATA_DIR}"
rm -rf /workspace/jdk-jdk-*-* java.tar.gz