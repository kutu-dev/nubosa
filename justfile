# Default recipe of the justfile
default: help

# Show this info message
help:
  just --list

# Generate Nix config to allow new subcommands and activate flake support
nix_config_path := `echo ${XDG_CONFIG_HOME:-$HOME/.config}/nix/`
setup:
  mkdir -p {{nix_config_path}}
  cp platform/common/dotfiles/nix/nix.conf {{nix_config_path}}

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
  rg TODO:

# Switch the nix-darwin and Home Manager configurations
switch-macos:
  nix run .#nix-darwin -- switch --flake .#nubosa
  nix run .#home-manager -- switch --flake .#macos

  # Imperative configurations
  nix run .#defaultbrowser -- firefoxdeveloperedition

# Switch the NixOS and Home Manager configurations
switch-nixos:
  sudo nixos-rebuild switch --flake .#nubosa
  nix run .#home-manager -- switch --flake .#nixos

  # Imperative configurations
  STEAM_EXTRA_COMPAT_TOOLS_PATHS="$HOME/.steam/root/compatibilitytools.d/" protonup -y
  rm -f "${XDG_CACHE_HOME:-$HOME/.cache}/tofi-drun"

# Switch the config based on the platform where the recipe is run
platform := if `uname -s` == "Linux" { "switch-nixos" } else { "switch-macos" }
switch:
  just {{platform}}
