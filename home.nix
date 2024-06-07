{ pkgs, config, ... }:

let
  dotfilesSymlink = path: config.lib.file.mkOutOfStoreSymlink ( "${config.xdg.userDirs.documents}/dev/nubosa/dotfiles/" + path );

in
{
  imports = [ programs/starship.nix ];

  home.username = "kutu";
  # TODO: This is not portable
  home.homeDirectory = "/Users/kutu";
  home.stateVersion = "24.11";

  home.packages = [
    pkgs.neovim
    pkgs.just
    pkgs.fish
    pkgs.eza
  ];

  xdg.configFile = {
    fish.source = dotfilesSymlink "fish";
    nvim.source = dotfilesSymlink "nvim";
  };

}
