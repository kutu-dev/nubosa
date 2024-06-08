{
  description = "Multiplatform dotfiles for development and gaming usage.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    flake-parts,
    mac-app-util,
  }:
    flake-parts.lib.mkFlake {inherit inputs;} ({withSystem, ...}: {
      systems = [
        "aarch64-darwin"
      ];

      perSystem = {
        inputs',
        pkgs,
        ...
      }: {
        formatter = pkgs.alejandra;

        packages.home-manager = inputs'.home-manager.packages.default;
      };

      flake = {
        homeConfigurations = withSystem "aarch64-darwin" ({system, ...}: {
          "kutu" = home-manager.lib.homeManagerConfiguration {
            pkgs = import nixpkgs {inherit system;};

            modules = [
              ./modules/macos/home.nix
              mac-app-util.homeManagerModules.default
              ./modules/common/home.nix
            ];
          };
        });
      };
    });
}
