{pkgs, ...}: with pkgs;
  [
    neovim
    vesktop
    just
    fish
    fortune
    eza
    wezterm
    jetbrains-mono
    (nerdfonts.override {
      fonts = [
        "NerdFontsSymbolsOnly"
      ];
    })
    glow

    # For nvim LSPs
    gcc
  ]
  ++ [
    pkgs.cumulus
  ]
