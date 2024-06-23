# Regenerate the system configurations for nirvana
switch-system-nirvana:
  nix run .#nix-darwin -- switch --flake .#nirvana

# Regenerate the home configurations for nirvana
switch-home-nirvana:
  nix run .#home-manager -- switch --flake .#nirvana

  # Imperative configurations
  nix run .#defaultbrowser -- firefoxdeveloperedition
  nix run .#mac-app-util -- mktrampoline "$HOME/Applications/Home Manager Apps/Vesktop.App/" "$HOME/Applications/Home Manager Trampolines/Vesktop.app"
