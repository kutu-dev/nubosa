{
  description = "Multiplatform dotfiles for development and gaming usage.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }: {
    packages.aarch64-darwin.default = home-manager.packages.aarch64-darwin.default;

    homeConfigurations = {
      "kutu" = home-manager.lib.homeManagerConfiguration {

        # TODO: Investigate about `ìmport` and `inherit`
        pkgs = import nixpkgs {
          system = "aarch64-darwin";
        };

        modules = [ ./home.nix ];
      };
    };
  };
}
