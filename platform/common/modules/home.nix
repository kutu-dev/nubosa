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

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "tokyo-night";
      vim_keys = true;
    };
  };

  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };

    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
    };
  };
}
