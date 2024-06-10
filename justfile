# Default recipe of the justfile
default: help

# Show this info message
help:
  just --list

# Generate Nix config to allow new subcommands and activate flake support
setup:
  cp nix.conf "${XDG_CONFIG_HOME:-$HOME/.config}/nix/"

# Format all the NIX files
format:
  nix fmt

# Update and relock the inputs of the flake
update:
  nix flake update --commit-lock-file

# Build the flake and switch the Home Manager config
switch-macos: setup
  nix run .#nix-darwin -- switch --flake .#nubosa
  nix run .#defaultbrowser -- firefoxdeveloperedition
