# Show this info message
help:
  just --list

nix_config_path := `echo ${XDG_CONFIG_HOME:-$HOME/.config}/nix/`

# Generate Nix config to allow the new subcommands and activate flake support
setup:
  mkdir -p {{nix_config_path}}
  cp dotfiles/nix/nix.conf {{nix_config_path}}

# Format and lint all NIX and POSIX shell files
check: lock-cumulus
  nix fmt
  nix run .#shfmt -- .
  ./scripts/misc/check-justfile.sh
  nix run .#stylua -- dotfiles/nvim/
  cd cumulus; just check

# Update and relock the inputs of the flake
update:
  nix flake update --commit-lock-file

# Relock the Cumulus package
lock-cumulus:
  nix flake lock --update-input cumulus

# See all the things that need to be done
todo:
  glow TODO.md
  rg TODO:
