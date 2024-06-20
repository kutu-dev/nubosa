#!/usr/bin/env sh
set -eo pipefail

JUSTFILE_JSON=$(just --dump-format json --dump --unstable)
recipes=$(echo "$JUSTFILE_JSON" | nix run .#jq -- -c --raw-output '.recipes | .[] | .name' | sort)

for recipe in $recipes; do
  output=$(mktemp --tmpdir "justfile-$recipe.XXXXXX")
  just -s "$recipe" | sed -n '/#\!/,$p' > "$output"
  if [[ -s "$output" ]]; then
    nix run .#shfmt -- -i 2 -w "$output"
    nix run .#shellcheck -- "$output"
  fi
done

cd /tmp && rm -f justfile-*
