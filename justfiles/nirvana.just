# Regenerate the system configurations for nirvana
switch-system-nirvana: lock-cumulus
  nix run .#nix-darwin -- switch --flake .#nirvana

# Regenerate the home configurations for nirvana
switch-home-nirvana: lock-cumulus
  nix run .#home-manager -- switch --flake .#nirvana

  # Imperative configurations
  nix run .#defaultbrowser -- firefoxdeveloperedition
