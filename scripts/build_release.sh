#!/usr/bin/env bash

set -e
set -o pipefail

projectPath=$(dirname `pwd`) 
folderName=$(basename $(dirname `pwd`)) 

mkdir -p "../../$folderName-cache"
mkdir -p "../../$folderName-cache/target"
mkdir -p "../../$folderName-cache/registry"

docker run --env $1 --rm -v "/$projectPath":/code \
  --mount type=bind,source=/$projectPath-cache/target,target=/code/target \
  --mount type=bind,source=/$projectPath-cache/registry,target=/usr/local/cargo/registry \
  --platform linux/amd64 \
  cosmwasm/workspace-optimizer:0.12.13