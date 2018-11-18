#!/usr/bin/env bash

set -Eeo pipefail

print_help () {
  echo "offline node installer for linux x64"
  echo "installs the latest nodejs version from the attached tarball."
  echo "usage: bash $0"
}

pinup () {
  echo "[node-install-latest-offline] $1"
}

panic () {
  echo $1
  exit 1
}

for opt in $@; do case $opt in
    -h|--help) print_help ; exit 0;;
esac; done

if [[ -z $(uname -s | grep -i linux) || -z $(uname -m | grep 64) ]]; then
  panic "$(uname -s) $(uname -m) not supported"
fi

tarball_head=$(awk '/^__TARBALL__/ {print NR + 1;exit 0;}' $0)
tail -n+$tarball_head $0 | sudo tar xzP --xform 's|^[^/]*/|/usr/local/|' --wildcards '*/*/*'
pinup "successfully installed node $(node -v) + npm $(npm -v)"

exit 0

__TARBALL__
