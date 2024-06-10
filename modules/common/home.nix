{
  pkgs,
  config,
  ...
}: let
  dotfilesSymlink = path: config.lib.file.mkOutOfStoreSymlink ("${config.xdg.userDirs.documents}/dev/nubosa/dotfiles/" + path);
in {
  imports = [./programs/starship.nix ./programs/firefox/default.nix];

  home.username = "kutu";
  home.stateVersion = "24.11";

  programs.zoxide.enable = true;

  xdg.configFile = {
    fish.source = dotfilesSymlink "fish";
    nvim.source = dotfilesSymlink "nvim";
    wezterm.source = dotfilesSymlink "wezterm";
  };
}
