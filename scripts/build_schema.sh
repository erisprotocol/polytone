#!/usr/bin/env bash

set -e
set -o pipefail

projectPath=$(cd "$(dirname "${0}")" && cd ../ && pwd)

for c in "$projectPath"/contracts/main/*; do
    (cd $c && cargo schema)
done