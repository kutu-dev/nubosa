# Default recipe of the justfile
default: help

# Show this info message
help:
  just --list

# Generate Nix config to allow new subcommands and activate flake support
nix_config_path := `echo ${XDG_CONFIG_HOME:-$HOME/.config}/nix/`
setup:
  mkdir -p {{nix_config_path}}
  cp nix.conf {{nix_config_path}}

# Format and lint all NIX and POSIX shell files
check:
  nix fmt
  nix run .#shfmt -- .
  ./check-justfile.sh

# Update and relock the inputs of the flake
update:
  nix flake update --commit-lock-file

# See all the things that need to be done
todo:
  glow TODO.md
  rg TODO

# Switch the nix-darwin config
switch-macos: setup
  nix run .#nix-darwin -- switch --flake .#nubosa
  nix run .#defaultbrowser -- firefoxdeveloperedition

# Switch the NixOS config
switch-nixos: setup
  sudo nixos-rebuild switch --flake .#nubosa

# Switch the config based on the platform where the recipe is run
platform := if `uname -s` == "Linux" { "switch-nixos" } else { "switch-macos" }
switch:
  just {{platform}}
