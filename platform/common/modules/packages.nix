{pkgs, ...}:
with pkgs; [
  neovim
  just
  fish
  fortune
  eza
  wezterm
  vesktop
  jetbrains-mono
  (nerdfonts.override {
    fonts = [
      "NerdFontsSymbolsOnly"
    ];
  })
  glow
  pavucontrol
  protonup

  # For nvim LSPs
  python312
  gcc
]
