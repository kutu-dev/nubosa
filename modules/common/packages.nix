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

  # For nvim
  lua-language-server
  ruff
  ccls
  vimPlugins.nvim-treesitter.withAllGrammars

  # Custom overrides
  cumulus
  nil
]
