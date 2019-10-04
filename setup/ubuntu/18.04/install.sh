#!/bin/bash
set -euo pipefail

if [[ "${EUID}" -ne 0 ]]; then
  echo 'This script must be run as root' >&2
  exit 1
fi

apt-get update;
apt-get install -y software-properties-common
add-apt-repository ppa:dreal/dreal -y  # For libibex-dev
apt-get update

# Install dReal
DREAL_VERSION=4.19.10.1
DREAL_DEBNAME=dreal_${DREAL_VERSION}_amd64.deb
DREAL_URL=https://dl.bintray.com/dreal/dreal/${DREAL_DEBNAME}
DREAL_SHA256=3763b4e80c5369652c50d9e81928076d3bf29d236d5a0fb70d63e5ddf9e57b25
apt-get install --no-install-recommends wget -y
wget ${DREAL_URL}
if echo "${DREAL_SHA256}  ${DREAL_DEBNAME}" | sha256sum -c; then
    apt-get install -y ./${DREAL_DEBNAME}
    rm ${DREAL_DEBNAME}
else
    echo "SHA256 does not match ${DREAL_DEBNAME}:"
    echo "    expected: ${DREAL_SHA256}"
    echo "    actual  : `sha256sum ${DREAL_DEBNAME}`"
    exit 1
fi
