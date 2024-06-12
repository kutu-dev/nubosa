{pkgs, ...}:
with pkgs; [
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
  python312
  gcc
] ++ [
pkgs.master.vesktop
]
