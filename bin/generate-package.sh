#!/usr/bin/env bash

set -e

org=linode

type="node"
version=$(jq -r '.version' package.json)
registry="https://npm.pkg.github.com/"
target_package_json="package.json"
target_tsconfig_json="tsconfig.json"
target_npm_name="@$org/apl-k8s-operator"

build_npm_package() {
    echo "Building $target_npm_name npm package"
    npm install && npm run build
    cd $DIR
}

build_npm_package

echo "The package code has been generated at root directory"