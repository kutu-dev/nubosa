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
  spotify
  obsidian
  aseprite
  ungoogled-chromium

  # For nvim
  lua-language-server
  ruff
  ccls
  vimPlugins.nvim-treesitter.withAllGrammars

  # Custom overrides
  cumulus
  master.wezterm
]
