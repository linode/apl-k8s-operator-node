#!/usr/bin/env bash
set -e
[ -n "$DEBUG" ] && set -x

unpublished_exists() {
  local version=$1
  if [ -n "$(npm info "@linode/apl-k8s-operator@$version")" ]; then
    return 0
  fi
  return 1
}