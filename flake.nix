{
  description = "Multiplatform dotfiles for development and gaming usage.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-firefox-darwin.url = "github:bandithedoge/nixpkgs-firefox-darwin";
    nixpkgs-firefox-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:lnl7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = inputs @ {self, ...}: let
    getPkgs = {
      system,
      extraOverlays ? [],
    }:
      import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays =
          [
            inputs.nur.overlay
          ]
          ++ extraOverlays;
      };

    forAllSystems = function:
      inputs.nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-darwin"
      ] (
        system:
          function
          (getPkgs {inherit system;})
      );
  in {
    formatter = forAllSystems (pkgs: pkgs.alejandra);

    packages = forAllSystems (pkgs: {
      defaultbrowser = pkgs.defaultbrowser;
      nix-darwin = inputs.nix-darwin.packages.default;
    });

    nixosConfigurations = import ./platform/nixos/modules/nixos.nix {
      inherit inputs;
      pkgs = getPkgs {system = "x86_64-linux";};
    };

    darwinConfigurations = import ./platform/macos/modules/darwin.nix {
      inherit inputs;
      pkgs = getPkgs {system = "aarch64-darwin";};
    };
  };
}
