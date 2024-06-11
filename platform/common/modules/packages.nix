{pkgs, ...}:
with pkgs; [
  neovim
  just
  fish
  fortune
  eza
  wezterm
  (discord.override {
    withVencord = true;
  })
  jetbrains-mono
  (nerdfonts.override {
    fonts = [
      "NerdFontsSymbolsOnly"
    ];
  })
  glow
  python312
]
