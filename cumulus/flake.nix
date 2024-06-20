{
  description = "Development environment for Cumulus.";

  outputs = inputs @ {self, ... }: let
    forAllSystems = function:
      inputs.nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-darwin"
      ] (
        system:
          function
          (
            import inputs.nixpkgs {inherit system;}
          )
      );

      getDependencies = pkgs: with pkgs.python312Packages; [
        platformdirs
        typer
        colorama
        jinja2
        pyyaml
      ];
  in {
    formatter = forAllSystems (pkgs: pkgs.alejandra);

    packages = forAllSystems (pkgs: {
      default = (pkgs.python312Packages.buildPythonPackage {
        name = "cumulus";
        version = "1.0.0";

        src = ./.;

        pyproject = true;
        doCheck = false;
      
        build-system = [
          pkgs.python312Packages.setuptools
        ];

        propagatedBuildInputs = getDependencies pkgs;
      });});

    devShells = forAllSystems (pkgs: {
      default = pkgs.mkShell {
        buildInputs = getDependencies pkgs;
      };
    });
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
}