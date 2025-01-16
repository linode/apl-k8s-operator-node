#!/usr/bin/env bash
version=$(jq -r '.version' package.json)

unpublished_exists() {
  local version=$1
  if [ -n "$(npm info "@linode/apl-k8s-operator@$version")" ]; then
    return 0
  fi
  return 1
}

release() {
  if ! unpublished_exists $version; then
    local pkg="@linode/apl-k8s-operator@$version"
    echo "Publishing newer package: $pkg"
    npm publish --access public
  fi
}

release
