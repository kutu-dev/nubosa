{
  inputs,
  pkgs,
  ...
}: {
  nubosa = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    inherit pkgs;

    modules = [
      ./configuration.nix
      ./hardware-configuration.nix

      inputs.home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.kutu.imports = [
          ./home.nix
          ../../common/modules/home.nix
        ];
      }
    ];
  };
}
