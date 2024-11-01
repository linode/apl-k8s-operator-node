#!/usr/bin/env bash
. bin/common.sh

version=$(jq -r '.version' package.json)

release() {
  if ! unpublished_exists $version; then
    local pkg="@linode/apl-k8s-operator@$version"
    echo "Publishing newer package: $pkg"
    npm publish --access public
    cd -
  fi
}

release
