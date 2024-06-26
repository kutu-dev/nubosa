{
  pkgs,
  config,
  ...
}: {
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

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };

  services.syncthing.enable = true;

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "theme";
      vim_keys = true;
    };
  };

  stylix = {
    base16Scheme = ../../dotfiles/stylix/theme.yaml;
    autoEnable = false;
    targets.gtk.enable = true;
    targets.firefox.enable = true;
    targets.firefox.profileNames = ["Kutu"];
  };

  nix = {
    package = pkgs.nix;

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };
}
