{pkgs, ...}:
with pkgs; [
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
  obs-studio

  # For nvim
  lua-language-server
  ruff
  vimPlugins.nvim-treesitter.withAllGrammars

  # Custom overrides
  cumulus
  nil
]
