{
  inputs,
  pkgs,
  ...
}: {
  nubosa = inputs.nix-darwin.lib.darwinSystem {
    system = "aarch64-darwin";
    inherit pkgs;

    modules = [
      ./configuration.nix

      inputs.home-manager.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.kutu.imports = [
          ./home.nix
          inputs.mac-app-util.homeManagerModules.default
          ../../common/modules/home.nix
        ];
      }
    ];
  };
}
