# Regenerate the system configurations for nirvana
switch-system-nirvana:
  nix run .#nix-darwin -- switch --flake .#nirvana

# Regenerate the home configurations for nirvana
switch-home-nirvana:
  nix run .#home-manager -- switch --flake .#nirvana

  # Imperative configurations
  nix run .#defaultbrowser -- firefoxdeveloperedition
