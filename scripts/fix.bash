#!/usr/bin/env bash
set -Eeuo pipefail
shopt -u nullglob
shopt -s globstar

REPO_PATH="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )/.."
cd "$REPO_PATH" || exit

chmod u+x ./**/*.bash
nix fmt ./**/*.nix