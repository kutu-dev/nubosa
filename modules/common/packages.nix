{pkgs, ...}:
let
  python = pkgs.python312.override {
    self = python;
    packageOverrides = self: super: {
      nubosa = self.buildPythonPackage {
        name = "nubosa";
        version = "1.0.0";

        src = ../../cli;

        pyproject = true;
        doCheck = false;
    
        build-system = [
          pkgs.python312Packages.setuptools
        ];

        propagatedBuildInputs = [
          pkgs.python312Packages.platformdirs
        ];
      };
    };
  };

in
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
  ]
  ++ [
    pkgs.master.vesktop
    (python.withPackages(ps: [
      ps.nubosa
    ]))
  ]
