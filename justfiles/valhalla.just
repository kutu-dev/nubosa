# Regenerate the system configurations for valhalla
switch-system-valhalla:
  sudo nixos-rebuild switch --flake .#valhalla

# Regenerate the home configurations for valhalla
switch-home-valhalla:
  nix run .#home-manager -- switch --flake .#nixos

  # Install the latest available GE-Proton version
  STEAM_EXTRA_COMPAT_TOOLS_PATHS="$HOME/.steam/root/compatibilitytools.d/" protonup -y

  # To make sure new installed applications are detected by tofi
  rm -f "${XDG_CACHE_HOME:-$HOME/.cache}/tofi-drun"
