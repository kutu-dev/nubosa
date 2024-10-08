{
  description = "Multiplatform dotfiles for development and gaming usage.";

  outputs = inputs @ {...}: let
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
            (final: prev: {
              master = import inputs.nixpkgs-master { inherit system; };
              cumulus = inputs.cumulus.packages."${system}".default;
            })
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
      shellcheck = pkgs.shellcheck;
      shfmt = pkgs.shfmt;
      jq = pkgs.jq;
      stylua = pkgs.stylua;

      home-manager = inputs.home-manager.packages."${system}".default;
      nix-darwin = inputs.nix-darwin.packages."${system}".default;
      mac-app-util = inputs.mac-app-util.packages."${system}".default;
    });

    apps = forAllSystems ({
      pkgs,
      system,
    }: {
      sponge = {
        type = "app";
        program = "${pkgs.moreutils}/bin/sponge";
      };
    });

    nixosConfigurations = import ./modules/nixos/nixos.nix {
      inherit inputs;
      pkgs = getPkgs {system = "x86_64-linux";};
    };

    darwinConfigurations = import ./modules/macos/darwin.nix {
      inherit inputs;
      pkgs = getPkgs {
        system = "aarch64-darwin";
        extraOverlays = [inputs.nixpkgs-firefox-darwin.overlay];
      };
    };

    # Having Home Manager declarations alone allow them to be executed from the
    # command line, obligatory for the dynamic theme changing
    homeConfigurations.valhalla = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = getPkgs {system = "x86_64-linux";};

      modules = [
        ./modules/nixos/home.nix
        inputs.stylix.homeManagerModules.stylix
        inputs.ags.homeManagerModules.default
        ./modules/common/home.nix
      ];
    };

    homeConfigurations.nirvana = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = getPkgs {
        system = "aarch64-darwin";
        extraOverlays = [inputs.nixpkgs-firefox-darwin.overlay];
      };

      modules = [
        ./modules/macos/home.nix
        inputs.stylix.homeManagerModules.stylix
        inputs.mac-app-util.homeManagerModules.default
        ./modules/common/home.nix
      ];
    };
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-master.url = "github:nixos/nixpkgs/master";

    nixpkgs-firefox-darwin.url = "github:bandithedoge/nixpkgs-firefox-darwin";
    nixpkgs-firefox-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:lnl7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    mac-app-util.url = "github:hraban/mac-app-util";
    mac-app-util.inputs.nixpkgs.follows = "nixpkgs";

    ags.url = "github:Aylur/ags";
    ags.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    cumulus.url = "path:./cumulus";
    cumulus.inputs.nixpkgs.follows = "nixpkgs";
  };
}
