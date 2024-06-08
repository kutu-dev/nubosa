# Default recipe of the justfile
default: help

# Show this info message
help:
  just --list

# Generate Nix config to allow new subcommands and activate flake support
setup:
  cp nix.conf "${XDG_CONFIG_HOME:-$HOME/.config}/nix/"

# Build the flake and switch the Home Manager config
switch-home:
  nix run .#home-manager -- switch --flake .
