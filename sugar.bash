#!/usr/bin/env bash

set -Eeo pipefail

print_help () {
  echo "chiefbuntu setup script for ubuntu desktop 18.04"
  echo ""
  echo "setup plumbing for a fresh ubuntu machine."
  echo ""
  echo "usage: bash $0 [-w wifi] [-p pass] [-l lang]"
  echo ""
  echo "options:"
  echo ""
  echo "  -w, --wifi    wifi name"
  echo "  -p, --pass    wifi password"
  echo "  -l, --lang    keyboard language layout"
  echo ""
  echo "use cases, fx:"
  echo "  - u just got a freshman ubuntu desktop without node, maybe bc.."
  echo "  - u r booting from a pendrive without a persistence layer"
  echo ""
  echo "if wifi details are passed, the script will try to connect to the"
  echo "wifi network. keyboard layout will be set if argument lang is passed."
  echo ""
  echo "example: bash $0 --wifi alibaba --pass sesameopen --lang de"
}

log_info () {
  echo "[chiefbuntu] $1"
}

while [[ $# -ne 0 ]]; do case $1 in
    -w|--wifi) wifi=$2; shift 2;;
    -p|--pass) pass=$2; shift 2;;
    -l|--lang) lang=$2; shift 2;;
    -h|--help) print_help; exit 0;;
esac; done

# remove amazon launcher etc
sudo apt purge --yes ubuntu-web-launchers > /dev/null 2>&1
log_info "just made sure ubuntu-web-launchers is purged"

# maybe set keyboard layout
if [[ -n $lang ]]; then
  setxkbmap $lang
  log_info "just set keyboard layout to $lang"
fi

# maybe connect to wifi
if [[ -n $wifi && -n $pass ]]; then
  log_info "attempting to connect to wifi $wifi"
  nmcli dev wifi connect $wifi password $pass > /dev/null 2>&1
  log_info "successfully connected to wifi $wifi"
fi

