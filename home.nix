{
  pkgs,
  config,
  ...
}: let 
  /**
    Generate the attribute set that can be used with `xdg.configFile` and `home.file` to link
    files located at `./dotfiles`in this repository.
  **/
  dotfilesSymlink = path: {
    source = config.lib.file.mkOutOfStoreSymlink ("${config.home.homeDirectory}/documents/dev/nubosa/dotfiles/" + path);
    force = true;
  };
in {
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    fish
    fortune-kind
    starship
    zoxide
    eza
  ];

  xdg.configFile = {
    "fish" = dotfilesSymlink "fish";
    "starship.toml" = dotfilesSymlink "starship.toml";
  };

  home.file.".gitconfig" = dotfilesSymlink "gitconfig";

  nix = {
    gc = {
      automatic = true;
      frequency = "weekly";
      options = "--delete-older-than 14d";
    };

    extraOptions = ''
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
    '';
  };
}
