{
  description = "Multiplatform dotfiles for development.";

  outputs = inputs @ {...}: let
    /*
      *
        Create a valid nixpkgs for the given system with some extra overlays that
        give access to the master and unstable channels.
    *
    */
    getPkgs = {
      system,
      extraOverlays ? [],
    }:
      import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;

        overlays =
          [
            (final: prev: {
              _unstable = import inputs.nixpkgs-unstable {inherit system;};
              _master = import inputs.nixpkgs-master {inherit system;};
            })
          ]
          ++ extraOverlays;
      };

    /*
      *
        Create crosssystem definitions for elements in the flake.nix.
    *
    */
    forAllSystems = function:
      inputs.nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-darwin"
      ] (
        system:
          function
          {
            pkgs = getPkgs {inherit system;};
            inherit system;
          }
      );
  in {
    formatter = forAllSystems ({pkgs, ...}: pkgs.alejandra);

    packages = forAllSystems ({
      pkgs,
      system,
    }: {
      defaultbrowser = pkgs.defaultbrowser;
      nix-darwin = inputs.nix-darwin.packages."${system}".default;
    });

    darwinConfigurations.epsilon = let
      system = "aarch64-darwin";
    in
      inputs.nix-darwin.lib.darwinSystem {
        inherit system;
        pkgs = getPkgs {
          inherit system;
        };

        modules = [
          ./darwin.nix
          inputs.home-manager.darwinModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.kutu = ./home.nix;
          }
        ];
      };
  };

  inputs = {
    # Use `?shallow=1` to avoid long download times

    nixpkgs.url = "github:NixOS/nixpkgs?shallow=1&ref=nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs?shallow=1&ref=nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs?shallow=1&ref=master";

    nix-darwin.url = "github:lnl7/nix-darwin?shallow=1&ref=nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager?shallow=1&ref=release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
}
