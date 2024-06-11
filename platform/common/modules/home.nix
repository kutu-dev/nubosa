{
  pkgs,
  config,
  ...
}: let
  dotfilesSymlink = path: config.lib.file.mkOutOfStoreSymlink ("/home/kutu/documents/dev/nubosa/platform/common/dotfiles/" + path);
in {
  imports = [./programs/starship.nix ./programs/firefox/default.nix];

  home.username = "kutu";
  home.stateVersion = "24.11";

  programs.zoxide.enable = true;
  programs.ripgrep.enable = true;

  programs.git = {
    enable = true;
    userName = "Kutu";
    userEmail = "code@dobon.dev";
    extraConfig.push.autoSetupRemote = true;
  };

  xdg.configFile = {
    fish.source = dotfilesSymlink "fish";
    nvim.source = dotfilesSymlink "nvim";
    wezterm.source = dotfilesSymlink "wezterm";
  };
}
