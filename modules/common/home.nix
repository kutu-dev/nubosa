{
  pkgs,
  config,
  ...
}: let
  dotfilesSymlink = path: config.lib.file.mkOutOfStoreSymlink ("${config.xdg.userDirs.documents}/dev/nubosa/dotfiles/" + path);
in {
  imports = [./programs/starship.nix];

  home.username = "kutu";
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    neovim
    just
    fish
    eza
    fortune
    wezterm
  ];

  programs.zoxide.enable = true;

  xdg.configFile = {
    fish.source = dotfilesSymlink "fish";
    nvim.source = dotfilesSymlink "nvim";
    wezterm.source = dotfilesSymlink "wezterm";
  };
}
