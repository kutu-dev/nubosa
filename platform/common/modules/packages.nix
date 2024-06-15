{pkgs, ...}:
with pkgs;
  [
    neovim
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
    python312

    /*
    (pkgs.python3Packages.buildPythonPackage {
      name = "nubosa";
      src = ../../../cli;
    })
    */
  ]
  ++ [
    pkgs.master.vesktop
  ]
