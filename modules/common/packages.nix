{pkgs, ...}:
with pkgs; [
  neovim
  vesktop
  just
  fish
  fortune
  eza
  kitty
  jetbrains-mono
  (nerdfonts.override {
    fonts = [
      "NerdFontsSymbolsOnly"
    ];
  })
  glow
  nil

  # For nvim
  lua-language-server
  ruff
  ccls
  vimPlugins.nvim-treesitter.withAllGrammars

  # Custom overrides
  cumulus
]
