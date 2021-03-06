#!/bin/bash
set -euxo pipefail

if [[ "${EUID}" -eq 0 ]]; then
  echo 'This script must NOT be run as root' >&2
  exit 1
fi

brew tap dreal-deps/ibex
brew tap dreal/dreal
brew install dreal --only-dependencies --build-from-source
