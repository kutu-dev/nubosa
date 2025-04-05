#!/usr/bin/env bash

if [ "${BASH_VERSINFO:-0}" -ge 4 ]; then
    echo "This version of Bash is too old, please update it to at least 4.0.0"
    exit 1
fi

set -Eeuo pipefail
shopt -u nullglob
shopt -s globstar

REPO_PATH="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )/.."
cd "$REPO_PATH" || exit

chmod u+x ./**/*.bash
nix fmt ./**/*.nix